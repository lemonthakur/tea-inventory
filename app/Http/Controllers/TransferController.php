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
use DB;
use Auth;

class TransferController extends Controller
{
    protected $moduleId = 1;
    public function index()
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        /*if(Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->where('user_id', Auth::id())->get();
        else
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->get();*/

        $user_ware_house = OwnLibrary::user_warehosue();

        $purchases = Purchase::whereNotNull('id');
        if($user_ware_house){

        }
        $purchases->orderBy('id','DESC');
        $purchases = $purchases->paginate(20);

        return view('backend.purchase.index', compact('purchases'));
    }

    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);

        $warehouses = Warehouse::select('id','name')->orderBy('name')->get();
        return view('backend.transfer.create',compact('warehouses'));
    }

    public function store(Request $request)
    {
        $rules = [
            "from_warehouse_id" => "required|integer",
            "to_warehouse_id" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",
            "waste.*" => "required",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
            "total_waste_input" => "required",
        ];

        $message = [
            "from_warehouse_id.required" => "From Warehouse is required",
            "to_warehouse_id.required" => "To Warehouse is required",

            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",
            "waste.*.required" => "Waste is required",

            "subtotal_input.required" => "Subtotal is required",
            "total_qty_input.required" => "Total quantity is required",
            "total_price_input.required" => "Total price is required",
            "total_waste_input.required" => "Total waste is required",
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();
                $purchase = new Purchase();

                $reference_no = 'pr-' . date("Ymd") . '-'. date("his");

                $purchase->reference_no         = $reference_no;
                $purchase->user_id              = Auth::user()->id;
                $purchase->warehouse_id         = $request->warehouse;
                $purchase->supplier_id          = $request->supplier;
                $purchase->item                 = count($request->product_id);

                $purchase->total_qty            = 0;
                $purchase->total_waste_qty      = 0;

                $purchase->total_cost           = $request->total_price_input;
                $purchase->grand_total          = $request->total_price_input;
                $purchase->grand_total_waste    = 0;
                $purchase->status  = 1;
                $purchase->note  = $request->note;

                if ($request->hasFile('document')){
                    $purchase_document = OwnLibrary::uploadImage($request->document, "purchase/document");
                    $purchase->document = $purchase_document;
                }
                $purchase->save();

                try {}catch(ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('/purchase')
                        ->withErrors( $e->getErrors() )
                        ->withInput();
                }catch(\Exception $e)
                {
                    DB::rollback();
                    throw $e;
                }

                $grand_total_waste = 0;
                $total_qty_input = 0;
                $total_waste_input = 0;
                for ($i = 0; count($request->product_id) > $i; $i++) {
                    try {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;
                        $waste_qty    = $request->waste[$i] * $unit_data->value;

                        $product_data->qty = $product_data->qty + $quantity;
                        $product_data->waste_qty = $product_data->waste_qty + $waste_qty;

                        $product_data->save();

                        $product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->warehouse ],
                        ])->first();

                        //add quantity to warehouse
                        if ($product_warehouse_data) {
                            $product_warehouse_data->qty = $product_warehouse_data->qty + $quantity;
                            $product_warehouse_data->waste_qty = $product_warehouse_data->waste_qty + $waste_qty;
                        }
                        else {
                            $product_warehouse_data = new Product_Warehouse();
                            $product_warehouse_data->product_id = $request->product_id[$i];
                            $product_warehouse_data->warehouse_id = $request->warehouse;
                            $product_warehouse_data->qty = $quantity;
                            $product_warehouse_data->waste_qty = $waste_qty;
                        }
                        $product_warehouse_data->save();

                            // Add to product purchase
                            $product_purchase = new ProductPurchase();
                            $product_purchase->purchase_id = $purchase->id ;
                            $product_purchase->product_id = $request->product_id[$i];
                            $product_purchase->qty = $request->qty[$i] * $unit_data->value;
                            $product_purchase->waste_qty = $request->waste[$i] * $unit_data->value;
                            $product_purchase->purchase_unit_id = $request->unit_id[$i];
                            $product_purchase->net_unit_cost = $request->unit_price[$i];
                            $product_purchase->total = $request->subtotal_input[$i];
                            $product_purchase->waste_total = $request->waste[$i]*$request->unit_price[$i];
                            $product_purchase->save();

                    } catch (ValidationException $e) {
                        DB::rollback();
                        return Redirect::to('/purchase')
                            ->withErrors($e->getErrors())
                            ->withInput();
                    } catch (\Exception $e) {
                        DB::rollback();
                        throw $e;
                    }

                    $grand_total_waste += $request->waste[$i] * $request->unit_price[$i];
                    $total_qty_input += $request->qty[$i] * $unit_data->value;
                    $total_waste_input += $request->waste[$i] * $unit_data->value;
                }
            }

            $up_purchase = Purchase::find($purchase->id);
            $up_purchase->grand_total_waste = $grand_total_waste;

            $up_purchase->total_qty        = $total_qty_input;
            $up_purchase->total_waste_qty  = $total_waste_input;

            $up_purchase->save();

            DB::commit();

            session()->flash("success", 'Purchase created successfully.');
            return redirect()->route("purchase.index");
        }
        // End of new store process===========================================
        //====================================================================

    }

    public function edit(Purchase $purchase)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $warehouses = Warehouse::select('id','name')->orderBy('name')->get();
        $suppliers = Supplier::select('id','name')->orderBy('name')->get();

        $product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();

        return view('backend.purchase.edit',compact('purchase', 'warehouses', 'suppliers', 'product_purchase_data'));
    }

    public function update(Request $request, Purchase $purchase)
    {
        $rules = [
            "warehouse" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",
            "waste.*" => "required",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
            "total_waste_input" => "required",
        ];

        $message = [
            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",
            "waste.*.required" => "Waste is required",

            "subtotal_input.required" => "Subtotal is required",
            "total_qty_input.required" => "Total quantity is required",
            "total_price_input.required" => "Total price is required",
            "total_waste_input.required" => "Total waste is required",
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();

                $lims_purchase_data = Purchase::find($purchase->id);
                $lims_product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();
                foreach ($lims_product_purchase_data as $product_purchase_data) {

                    $old_qty_value   = $product_purchase_data->qty;
                    $old_waste_value = $product_purchase_data->waste_qty;

                    $lims_purchase_unit_data = Unit::find($product_purchase_data->purchase_unit_id);
                    $lims_product_data = Product::find($product_purchase_data->product_id);

                    $lims_product_warehouse_data = Product_Warehouse::where([
                        ['product_id', $product_purchase_data->product_id],
                        ['warehouse_id', $lims_purchase_data->warehouse_id],
                    ])->first();

                    $lims_product_data->qty -= $old_qty_value;
                    $lims_product_data->waste_qty -= $old_waste_value;

                    $lims_product_warehouse_data->qty -= $old_qty_value;
                    $lims_product_warehouse_data->waste_qty -= $old_waste_value;
                    $lims_product_warehouse_data->save();

                    $lims_product_data->save();
                    $product_purchase_data->delete();
                }


                $purchase->warehouse_id         = $request->warehouse;
                $purchase->supplier_id          = $request->supplier;
                $purchase->item                 = count($request->product_id);

                $purchase->total_qty            = 0;
                $purchase->total_waste_qty      = 0;

                $purchase->total_cost           = $request->total_price_input;
                $purchase->grand_total          = $request->total_price_input;
                $purchase->grand_total_waste    = 0;
                $purchase->status  = 1;
                $purchase->note  = $request->note;

                if ($request->hasFile('document')){
                    if($purchase->file) @unlink($purchase->document);
                    $purchase_document = OwnLibrary::uploadImage($request->document, "purchase/document");
                    $purchase->document = $purchase_document;
                }
                $purchase->save();

                try {}catch(ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('/purchase')
                        ->withErrors( $e->getErrors() )
                        ->withInput();
                }catch(\Exception $e)
                {
                    DB::rollback();
                    throw $e;
                }

                $grand_total_waste = 0;
                $total_qty_input = 0;
                $total_waste_input = 0;
                for ($i = 0; count($request->product_id) > $i; $i++) {
                    try {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;
                        $waste_qty    = $request->waste[$i] * $unit_data->value;

                        $product_data->qty = $product_data->qty + $quantity;
                        $product_data->waste_qty = $product_data->waste_qty + $waste_qty;

                        $product_data->save();

                        $product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->warehouse ],
                        ])->first();

                        //add quantity to warehouse
                        if ($product_warehouse_data) {
                            $product_warehouse_data->qty = $product_warehouse_data->qty + $quantity;
                            $product_warehouse_data->waste_qty = $product_warehouse_data->waste_qty + $waste_qty;
                        }
                        else {
                            $product_warehouse_data = new Product_Warehouse();
                            $product_warehouse_data->product_id = $request->product_id[$i];
                            $product_warehouse_data->warehouse_id = $request->warehouse;
                            $product_warehouse_data->qty = $quantity;
                            $product_warehouse_data->waste_qty = $waste_qty;
                        }
                        $product_warehouse_data->save();

                        // Add to product purchase
                        $product_purchase = new ProductPurchase();
                        $product_purchase->purchase_id = $purchase->id ;
                        $product_purchase->product_id = $request->product_id[$i];
                        $product_purchase->qty = $request->qty[$i] * $unit_data->value;
                        $product_purchase->waste_qty = $request->waste[$i] * $unit_data->value;
                        $product_purchase->purchase_unit_id = $request->unit_id[$i];
                        $product_purchase->net_unit_cost = $request->unit_price[$i];
                        $product_purchase->total = $request->subtotal_input[$i];
                        $product_purchase->waste_total = $request->waste[$i]*$request->unit_price[$i];
                        $product_purchase->save();

                    } catch (ValidationException $e) {
                        DB::rollback();
                        return Redirect::to('/purchase')
                            ->withErrors($e->getErrors())
                            ->withInput();
                    } catch (\Exception $e) {
                        DB::rollback();
                        throw $e;
                    }

                    $grand_total_waste += $request->waste[$i] * $request->unit_price[$i];
                    $total_qty_input += $request->qty[$i] * $unit_data->value;
                    $total_waste_input += $request->waste[$i] * $unit_data->value;
                }
            }

            $up_purchase = Purchase::find($purchase->id);
            $up_purchase->grand_total_waste = $grand_total_waste;

            $up_purchase->total_qty        = $total_qty_input;
            $up_purchase->total_waste_qty  = $total_waste_input;

            $up_purchase->save();

            DB::commit();

            session()->flash("success", 'Purchase updated successfully.');
            return redirect()->route("purchase.index");
        }
        // End of new store process===========================================
        //====================================================================
    }

    public function purchase_details_get(Request $request){
        $purchase_id = $request->purchase_id;
        if($purchase_id){
            $purchase = Purchase::find($purchase_id);

            $html = '';
            $html .= '<strong>Date: </strong>'.date("d/m/Y", strtotime($purchase->created_at));
            $html .= '<br><strong>Reference: </strong>'.$purchase->reference_no;
            $html .= '<br><br><div class="row"><div class="col-md-6"><strong>From</strong>';
            $html .= '<br>'.$purchase->warehouse->name;
            $html .= '<br>'.$purchase->warehouse->contact_no;
            $html .= '<br>'.$purchase->warehouse->address;
            $html .= '</div><div class="col-md-6"><div class="float-right"><strong>To:</strong>';
            $html .= '<br><br><br>';
            $html .= '</div></div></div>';

            $lims_product_purchase_data = ProductPurchase::where('purchase_id', $purchase_id)->get();
            $html .= '<br><br><br>
                <table class="table table-bordered product-purchase-list">
                    <thead>
                        <th>#</th>
                        <th>product</th>
                        <th class="text-center">Qty</th>
                        <th class="text-center">Waste</th>
                        <th class="text-center">Unit Cost</th>
                        <th class="text-center">Subtotal</th>
                    </thead>
                    <tbody>';

                    $sl = 1;
                    foreach ($lims_product_purchase_data as $key => $product_purchase_data) {
                        $product = Product::find($product_purchase_data->product_id);
                        $unit = Unit::find($product_purchase_data->purchase_unit_id);

                        $html .='<tr>';
                            $html .='<td><strong>'.$sl++.'</strong></td>';
                            $html .='<td>'.$product->name.' ('.$product->code.')</td>';
                            $html .='<td class="text-right">'.$product_purchase_data->qty/$unit->value.' '.$unit->name.'</td>';
                            $html .='<td class="text-right">'.$product_purchase_data->waste_qty/$unit->value.' '.$unit->name.'</td>';
                            $html .='<td class="text-right">'.$product_purchase_data->net_unit_cost.'</td>';
                            $html .='<td class="text-right">'.$product_purchase_data->total.'</td>';
                        $html .='</tr>';
                    }

            $html .='<tr>';
                $html .='<td colspan="5"><strong>Total</strong></td>';
                $html .='<td class="text-right"><strong>'.number_format($purchase->grand_total, 2).'</strong></td>';
            $html .='</tr>';

            $html .= '</tbody>
                    </table>';
            $html .= '<div id="purchase-footer" class="modal-body">';
                $html .= 'Note: '.$purchase->note;
                $html .= '<br><br><strong>Created By:</strong>';
                $html .= '<br>'.$purchase->userinfo->name;
                $html .= '<br>'.$purchase->userinfo->email;
            $html .= '</div>';

            return $html;
        }
    }

    public function purchaseFileDownload($id){
        $id = $id;
        if($id){
            $purchase = Purchase::find($id);
            if($purchase->document){
                $headers = ['Content-Type: application/pdf'];

                $a = str_replace('public/', '', $purchase->document);
                $file= public_path().'/'. $a;

                $my_url = $purchase->document;
                $fileName = substr($my_url, strrpos($my_url, '/' )+1);
                return response()->download($file, $fileName, $headers);
            }
        }else{
            echo "<h2>Not found</h2>";
        }
    }

    public function destroy($id)
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('purchases-delete')){
            $lims_purchase_data = Purchase::find($id);
            $lims_product_purchase_data = ProductPurchase::where('purchase_id', $id)->get();
            $lims_payment_data = Payment::where('purchase_id', $id)->get();
            foreach ($lims_product_purchase_data as $product_purchase_data) {
                $lims_purchase_unit_data = Unit::find($product_purchase_data->purchase_unit_id);
                if ($lims_purchase_unit_data->operator == '*')
                    $recieved_qty = $product_purchase_data->recieved * $lims_purchase_unit_data->operation_value;
                else
                    $recieved_qty = $product_purchase_data->recieved / $lims_purchase_unit_data->operation_value;

                $lims_product_data = Product::find($product_purchase_data->product_id);
                if($product_purchase_data->variant_id) {
                    $lims_product_variant_data = ProductVariant::select('id', 'qty')->FindExactProduct($lims_product_data->id, $product_purchase_data->variant_id)->first();
                    $lims_product_warehouse_data = Product_Warehouse::FindProductWithVariant($product_purchase_data->product_id, $product_purchase_data->variant_id, $lims_purchase_data->warehouse_id)
                        ->first();
                    $lims_product_variant_data->qty -= $recieved_qty;
                    $lims_product_variant_data->save();
                }
                else {
                    $lims_product_warehouse_data = Product_Warehouse::FindProductWithoutVariant($product_purchase_data->product_id, $lims_purchase_data->warehouse_id)
                        ->first();
                }

                $lims_product_data->qty -= $recieved_qty;
                $lims_product_warehouse_data->qty -= $recieved_qty;

                $lims_product_warehouse_data->save();
                $lims_product_data->save();
                $product_purchase_data->delete();
            }
            foreach ($lims_payment_data as $payment_data) {
                if($payment_data->paying_method == "Cheque"){
                    $payment_with_cheque_data = PaymentWithCheque::where('payment_id', $payment_data->id)->first();
                    $payment_with_cheque_data->delete();
                }
                elseif($payment_data->paying_method == "Credit Card"){
                    $payment_with_credit_card_data = PaymentWithCreditCard::where('payment_id', $payment_data->id)->first();
                    $lims_pos_setting_data = PosSetting::latest()->first();
                    \Stripe\Stripe::setApiKey($lims_pos_setting_data->stripe_secret_key);
                    \Stripe\Refund::create(array(
                        "charge" => $payment_with_credit_card_data->charge_id,
                    ));

                    $payment_with_credit_card_data->delete();
                }
                $payment_data->delete();
            }

            $lims_purchase_data->delete();
            return redirect('purchases')->with('not_permitted', 'Purchase deleted successfully');;
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
