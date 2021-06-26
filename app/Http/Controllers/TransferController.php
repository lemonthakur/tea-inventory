<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Warehouse;
use App\Models\Supplier;
use App\Models\Product;
use App\Models\Unit;
use App\Models\Purchase;
use App\Models\ProductPurchase;
use App\Models\Product_Warehouse;
use App\Models\User;
use App\Models\Transfer;
use App\Models\ProductTransfer;
use DB;
use Auth;

class TransferController extends Controller
{
    protected $moduleId = 16;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);
        /*if(Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->where('user_id', Auth::id())->get();
        else
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->get();*/

        $user_ware_house = OwnLibrary::user_warehosue();
        $transfers = Transfer::whereNotNull('id');
        if($user_ware_house){
            $transfers->whereIn('from_warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $product_id = $request->input('product_ser');
            $transfers->whereHas('transfer_details', function($query) use($product_id) {
                $query->where('product_id', $product_id);
            });
        }
        if($request->input('start_date'))
            $transfers->whereDate('created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        if($request->input('end_date'))
            $transfers->whereDate('created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));

        $transfers->orderBy('id','DESC');
        $transfers = $transfers->paginate(20);

        return view('backend.transfer.index', compact('transfers'));
    }

    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);

        $user_ware_house = OwnLibrary::user_warehosue();
        $warehouse_from = Warehouse::select('id','name')->where('status', 1)->orderBy('name');
        if($user_ware_house){
            $warehouse_from->whereIn('id', $user_ware_house);
        }
        $warehouse_from = $warehouse_from->get();

        $warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name')->get();

        return view('backend.transfer.create',compact('warehouses', 'warehouse_from'));
    }

    public function store(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $rules = [
            "from_warehouse_id" => "required|integer",
            "to_warehouse_id" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id"    => "required|array|min:1",
            "product_id.*" => "required|integer",
            "qty"    => "required|array|min:1",
            "qty.*" => "required",
            "subtotal_input"    => "required|array|min:1",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
        ];

        $message = [
            "from_warehouse_id.required" => "From Warehouse is required",
            "to_warehouse_id.required" => "To Warehouse is required",

            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",

            "subtotal_input.required" => "Subtotal is required",
            "total_qty_input.required" => "Total quantity is required",
            "total_price_input.required" => "Total price is required",
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();
                try {
                    $transfer = new Transfer();

                    $reference_no = 'tr-' . date("Ymd") . '-'. date("his");

                    $transfer->reference_no         = $reference_no;
                    $transfer->user_id              = Auth::user()->id;
                    $transfer->from_warehouse_id    = $request->from_warehouse_id;
                    $transfer->to_warehouse_id      = $request->to_warehouse_id;
                    $transfer->item                 = count($request->product_id);

                    $transfer->total_qty            = 0;

                    $transfer->total_cost           = $request->total_price_input;
                    $transfer->grand_total          = $request->total_price_input;
                    $transfer->note  = $request->note;

                    if ($request->hasFile('document')){
                        $transfer_document = OwnLibrary::uploadImage($request->document, "transfer/document");
                        $transfer->document = $transfer_document;
                    }
                    $transfer->save();

                    $total_qty_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;

                        $lims_product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->from_warehouse_id ],
                        ])->first();

                        $lims_product_warehouse_data->qty -= $quantity;
                        $lims_product_warehouse_data->save();


                        $lims_product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->to_warehouse_id ],
                        ])->first();

                        //add quantity to destination warehouse
                        if ($lims_product_warehouse_data){
                            $lims_product_warehouse_data->qty += $quantity;
                        } else {
                            $lims_product_warehouse_data = new Product_Warehouse();
                            $lims_product_warehouse_data->product_id = $request->product_id[$i];
                            $lims_product_warehouse_data->warehouse_id = $request->to_warehouse_id;
                            $lims_product_warehouse_data->qty = $quantity;
                        }
                        $lims_product_warehouse_data->save();

                        // Add to product transfer
                        $product_transfer = new ProductTransfer();
                        $product_transfer->transfer_id = $transfer->id ;
                        $product_transfer->product_id = $request->product_id[$i];
                        $product_transfer->qty = $request->qty[$i] * $unit_data->value;
                        $product_transfer->purchase_unit_id = $request->unit_id[$i];
                        $product_transfer->net_unit_cost = $request->unit_price[$i];
                        $product_transfer->total = $request->subtotal_input[$i];

                        $product_transfer->org_input        = $request->qty[$i];
                        $product_transfer->unit_value       = $unit_data->value;

                        $product_transfer->save();

                        $total_qty_input += $request->qty[$i] * $unit_data->value;

                        $up_transfer = Transfer::find($transfer->id);

                        $up_transfer->total_qty        = $total_qty_input;
                        $up_transfer->save();
                    }

                    DB::commit();

                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('/transfer')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }
            }

            session()->flash("success", 'Transfer created successfully.');
            return redirect()->route("transfer.index");
        }

    }

    public function edit(Transfer $transfer)
    {
        OwnLibrary::validateAccess($this->moduleId,3);

        $user_ware_house = OwnLibrary::user_warehosue();
        $warehouse_from = Warehouse::select('id','name')->where('status', 1)->orderBy('name');
        if($user_ware_house){
            $warehouse_from->whereIn('id', $user_ware_house);
        }
        $warehouse_from = $warehouse_from->get();
        $warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name')->get();

        $product_transfer_data = ProductTransfer::where('transfer_id', $transfer->id)->get();

        return view('backend.transfer.edit',compact('transfer', 'warehouses', 'product_transfer_data', 'warehouse_from'));
    }

    public function update(Request $request, Transfer $transfer)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            "from_warehouse_id" => "required|integer",
            "to_warehouse_id" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id"    => "required|array|min:1",
            "product_id.*" => "required|integer",
            "qty"    => "required|array|min:1",
            "qty.*" => "required",
            "subtotal_input"    => "required|array|min:1",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
        ];

        $message = [
            "from_warehouse_id.required" => "From Warehouse is required",
            "to_warehouse_id.required" => "To Warehouse is required",

            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",

            "subtotal_input.required" => "Subtotal is required",
            "total_qty_input.required" => "Total quantity is required",
            "total_price_input.required" => "Total price is required",
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();
                try {

                    $lims_transfer_data = Transfer::find($transfer->id);
                    $lims_product_transfer_data = ProductTransfer::where('transfer_id', $transfer->id)->get();

                    foreach ($lims_product_transfer_data as $product_transfer_data) {

                        $old_qty_value   = $product_transfer_data->qty;

                        $lims_purchase_unit_data = Unit::find($product_transfer_data->purchase_unit_id);
                        $lims_product_data = Product::find($product_transfer_data->product_id);

                        $lims_product_from_warehouse_data = Product_Warehouse::where([
                            ['product_id', $product_transfer_data->product_id],
                            ['warehouse_id', $lims_transfer_data->from_warehouse_id],
                        ])->first();

                        $lims_product_from_warehouse_data->qty += $old_qty_value;
                        $lims_product_from_warehouse_data->save();

                        $lims_product_to_warehouse_data = Product_Warehouse::where([
                            ['product_id', $product_transfer_data->product_id],
                            ['warehouse_id', $lims_transfer_data->to_warehouse_id],
                        ])->first();

                        $lims_product_to_warehouse_data->qty -= $old_qty_value;
                        $lims_product_to_warehouse_data->save();

                        $product_transfer_data->delete();
                    }


                    $lims_transfer_data->from_warehouse_id    = $request->from_warehouse_id;
                    $lims_transfer_data->to_warehouse_id      = $request->to_warehouse_id;
                    $lims_transfer_data->item                 = count($request->product_id);

                    $lims_transfer_data->total_qty            = 0;

                    $lims_transfer_data->total_cost           = $request->total_price_input;
                    $lims_transfer_data->grand_total          = $request->total_price_input;
                    $lims_transfer_data->note  = $request->note;

                    if ($request->hasFile('document')){
                        if($lims_transfer_data->file) @unlink($lims_transfer_data->document);
                        $transfer_document = OwnLibrary::uploadImage($request->document, "transfer/document");
                        $lims_transfer_data->document = $transfer_document;
                    }
                    $lims_transfer_data->save();

                    $total_qty_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {

                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;

                        $lims_product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->from_warehouse_id ],
                        ])->first();

                        $lims_product_warehouse_data->qty -= $quantity;
                        $lims_product_warehouse_data->save();

                        $lims_product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->to_warehouse_id ],
                        ])->first();

                        //add quantity to destination warehouse
                        if ($lims_product_warehouse_data){
                            $lims_product_warehouse_data->qty += $quantity;
                        } else {
                            $lims_product_warehouse_data = new Product_Warehouse();
                            $lims_product_warehouse_data->product_id = $request->product_id[$i];
                            $lims_product_warehouse_data->warehouse_id = $request->to_warehouse_id;
                            $lims_product_warehouse_data->qty = $quantity;
                        }
                        $lims_product_warehouse_data->save();

                        // Add to product transfer
                        $product_transfer = new ProductTransfer();
                        $product_transfer->transfer_id = $transfer->id ;
                        $product_transfer->product_id = $request->product_id[$i];
                        $product_transfer->qty = $request->qty[$i] * $unit_data->value;
                        $product_transfer->purchase_unit_id = $request->unit_id[$i];
                        $product_transfer->net_unit_cost = $request->unit_price[$i];
                        $product_transfer->total = $request->subtotal_input[$i];

                        $product_transfer->org_input        = $request->qty[$i];
                        $product_transfer->unit_value       = $unit_data->value;

                        $product_transfer->save();

                        $total_qty_input += $request->qty[$i] * $unit_data->value;
                    }

                    $up_transfer = Transfer::find($transfer->id);

                    $up_transfer->total_qty        = $total_qty_input;
                    $up_transfer->save();

                    DB::commit();
                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('/transfer')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }

            }

            session()->flash("success", 'Transfer updated successfully.');
            return redirect()->route("transfer.index");
        }
        // End of new store process===========================================
        //====================================================================
    }

    public function transfer_details_get(Request $request){
        $transfer_id = $request->transfer_id;
        if($transfer_id){
            $transfer = Transfer::find($transfer_id);

            $html = '';
            $html .= '<strong>Date: </strong>'.date("d/m/Y", strtotime($transfer->created_at));
            $html .= '<br><strong>Reference: </strong>'.$transfer->reference_no;
            $html .= '<br><br><div class="row"><div class="col-md-6"><strong>From</strong>';
            $html .= '<br>'.$transfer->fromWarehouse->name;
            $html .= '<br>'.$transfer->fromWarehouse->contact_no;
            $html .= '<br>'.$transfer->fromWarehouse->address;
            $html .= '</div><div class="col-md-6"><div class="float-right"><strong>To:</strong>';
            $html .= '<br>'.$transfer->toWarehouse->name;
            $html .= '<br>'.$transfer->toWarehouse->contact_no;
            $html .= '<br>'.$transfer->toWarehouse->address;
            $html .= '</div></div></div>';

            $lims_product_transfer_data = ProductTransfer::where('transfer_id', $transfer_id)->get();
            $html .= '<br><br><br>
                <table class="table table-bordered product-transfer-list">
                    <thead>
                        <th>#</th>
                        <th>product</th>
                        <th class="text-center">Qty</th>
                        <th class="text-center">Unit Cost</th>
                        <th class="text-center">Subtotal</th>
                    </thead>
                    <tbody>';

                    $sl = 1;
                    foreach ($lims_product_transfer_data as $key => $product_transfer_data) {
                        $product = Product::find($product_transfer_data->product_id);
                        $unit = Unit::find($product_transfer_data->purchase_unit_id);

                        $html .='<tr>';
                            $html .='<td><strong>'.$sl++.'</strong></td>';
                            $html .='<td>'.$product->name.' ('.$product->code.')</td>';
                            $html .='<td class="text-right">'.$product_transfer_data->qty/$unit->value.' '.$unit->name.'</td>';
                            $html .='<td class="text-right">'.$product_transfer_data->net_unit_cost.'</td>';
                            $html .='<td class="text-right">'.$product_transfer_data->total.'</td>';
                        $html .='</tr>';
                    }

            $html .='<tr>';
                $html .='<td colspan="4"><strong>Total</strong></td>';
                $html .='<td class="text-right"><strong>'.number_format($transfer->grand_total, 2).'</strong></td>';
            $html .='</tr>';

            $html .= '</tbody>
                    </table>';
            $html .= '<div id="transfer-footer" class="modal-body">';
                $html .= 'Note: '.$transfer->note;
                $html .= '<br><br><strong>Created By:</strong>';
                $html .= '<br>'.$transfer->user->name;
                $html .= '<br>'.$transfer->user->email;
            $html .= '</div>';

            return $html;
        }
    }

    public function transferFileDownload ($id){
        $id = $id;
        if($id){
            $transfer = Transfer::find($id);
            if($transfer->document){
                $headers = ['Content-Type: application/pdf'];

                $a = str_replace('public/', '', $transfer->document);
                $file= public_path().'/'. $a;

                $my_url = $transfer->document;
                $fileName = substr($my_url, strrpos($my_url, '/' )+1);
                return response()->download($file, $fileName, $headers);
            }
        }else{
            echo "<h2>Not found</h2>";
        }
    }

    public function destroy(Transfer $transfer)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        $lims_product_transfer_data = ProductTransfer::where('transfer_id', $transfer->id)->get();
        DB::beginTransaction();
        try {
            foreach ($lims_product_transfer_data as $product_transfer_data) {
                $lims_purchase_unit_data = Unit::find($product_transfer_data->purchase_unit_id);

                $old_qty_value   = $product_transfer_data->qty;

                $lims_product_from_warehouse_data = Product_Warehouse::where([
                    ['product_id', $product_transfer_data->product_id],
                    ['warehouse_id', $transfer->from_warehouse_id],
                ])->first();

                $lims_product_from_warehouse_data->qty += $old_qty_value;
                $lims_product_from_warehouse_data->save();

                $lims_product_to_warehouse_data = Product_Warehouse::where([
                    ['product_id', $product_transfer_data->product_id],
                    ['warehouse_id', $transfer->to_warehouse_id],
                ])->first();

                $lims_product_to_warehouse_data->qty -= $old_qty_value;
                $lims_product_to_warehouse_data->save();

                $product_transfer_data->delete();
            }
            DB::commit();
        } catch (ValidationException $e) {
            DB::rollback();
            return Redirect::to('purchase')
                ->withErrors($e->getErrors())
                ->withInput();
        } catch (\Exception $e) {
            DB::rollback();
            throw $e;
        }

        if ($transfer->delete()){
            session()->flash("success","Transfer deleted successfully");
            return redirect()->back();
        }else{
            session()->flash("error","Transfer not deleted");
            return redirect()->back();
        }

    }

    public function getProduct(Request $request)
    {
        $id = $request->warehouse_id;
        $search = $request->search;

        $products = Product::join('product_warehouse','product_warehouse.product_id','=','products.id')
                ->select('products.id', DB::raw("CONCAT(code,' ','(',products.name,')') AS text"))
            ->where('product_warehouse.warehouse_id','=',$id)
            ->where('product_warehouse.qty','>',0);
        $products->where(function($query) use($search){
                $query->where('products.name','LIKE',"$search%");
                $query->orWhere('products.code','LIKE',"$search%");
        });

        $products = $products->limit(10)->get();
        return response()->json($products);
    }

    public function getProductQty(Request $request){
        $id = $request->warehouse_id;
        $product_id = $request->product_id;

        $products = Product::join('product_warehouse','product_warehouse.product_id','=','products.id')
            ->select('product_warehouse.qty as pwqty', 'product_warehouse.waste_qty as pwWaste_qty', 'products.*')
            ->where('product_warehouse.warehouse_id','=',$id)
            ->where('product_warehouse.product_id','=',$product_id)
            ->where('product_warehouse.qty','>',0)->first();

        $array['qty'] = $products->pwqty/$products->unit->value;
        $array['waste_qty'] = $products->pwWaste_qty/$products->unit->value;
        $array['unit_value'] = $products->unit->value;

        return json_encode($array);
    }
}
