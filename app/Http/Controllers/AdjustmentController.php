<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Warehouse;
use App\Models\Product;
use App\Models\Unit;
use App\Models\Purchase;
use App\Models\ProductPurchase;
use App\Models\Product_Warehouse;
use App\Models\User;
use App\Models\Adjustment;
use App\Models\ProductAdjustment;
use DB;
use Auth;

class AdjustmentController extends Controller
{
    protected $moduleId = 13;
    public function index()
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        $adjustments = Adjustment::whereNotNull('id');
        if($user_ware_house){
            $adjustments->whereIn('warehouse_id', $user_ware_house);
        }
        $adjustments->orderBy('id','DESC');
        $adjustments = $adjustments->paginate(20);
        return view('backend.adjustment.index', compact('adjustments'));
    }

    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);

        $user_ware_house = OwnLibrary::user_warehosue();
        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();
        return view('backend.adjustment.create',compact('warehouses'));
    }

    public function store(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $rules = [
            "warehouse_id" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",

            /*"waste.*" => "required",
            "qty.*" => "required_without:waste.*",
            "waste.*" => "required_without:qty.*",*/
        ];

        $message = [
            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",

            /*"waste.*.required" => "Waste is required",
            "qty.*.required_without" => "The Quantity field is required when Waste is not present.",
            "waste.*.required_without" => "The Waste field is required when Quantity is not present.",*/
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();
                try {
                    $adjustment = new Adjustment();
                    $reference_no = 'adr-' . date("Ymd") . '-'. date("his");

                    $adjustment->reference_no         = $reference_no;
                    $adjustment->warehouse_id         = $request->warehouse_id;
                    $adjustment->item                 = count($request->product_id);
                    $adjustment->note                 = $request->note;
                    $adjustment->total_qty            = 0;

                    if ($request->hasFile('document')){
                        $adjustment_document = OwnLibrary::uploadImage($request->document, "adjustment/document");
                        $adjustment->document = $adjustment_document;
                    }
                    $adjustment->save();

                    $total_qty_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);

                        $quantity     = $request->qty[$i] ? $request->qty[$i] * $unit_data->value : 0 * $unit_data->value;

                        $product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->warehouse_id[$i] ],
                        ])->first();

                        if($request->action[$i] == '-'){
                            $product_data->qty -= $quantity;
                            $product_warehouse_data->qty -= $quantity;
                        }
                        elseif($request->action[$i] == '+'){
                            $product_data->qty += $quantity;
                            $product_warehouse_data->qty += $quantity;
                        }

                        $product_data->save();
                        $product_warehouse_data->save();

                        // Add to product purchase
                        $product_adjustment = new ProductAdjustment();
                        $product_adjustment->adjustment_id = $adjustment->id;
                        $product_adjustment->product_id = $request->product_id[$i];
                        $product_adjustment->qty = $request->qty[$i] * $unit_data->value;
                        $product_adjustment->action = $request->action[$i];

                        $product_adjustment->adjustment_unit_id = $request->unit_id[$i];
                        $product_adjustment->net_unit_cost      = $request->unit_price[$i];
                        $product_adjustment->total              = $request->qty[$i] * $request->unit_price[$i];

                        $product_adjustment->org_input        = $request->qty[$i];
                        $product_adjustment->unit_value       = $unit_data->value;

                        $product_adjustment->save();

                        $total_qty_input += $request->qty[$i] ? $request->qty[$i] * $unit_data->value : 0 * $unit_data->value;
                    }

                        $up_adjustment = Adjustment::find($adjustment->id);

                        $up_adjustment->total_qty        = $total_qty_input;
                        $up_adjustment->save();
                    DB::commit();
                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('qty_adjustment')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }
            }

            session()->flash("success", 'Adjustment created successfully.');
            return redirect()->route("qty_adjustment.index");
        }
        // End of new store process===========================================
        //====================================================================

    }

    public function edit(Request $request, $id)
    {
        OwnLibrary::validateAccess($this->moduleId,3);

        $adjustment = Adjustment::find($id);

        $user_ware_house = OwnLibrary::user_warehosue();
        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        $product_adjustment_data = ProductAdjustment::where('adjustment_id', $adjustment->id)->get();

        return view('backend.adjustment.edit',compact('adjustment', 'warehouses', 'product_adjustment_data'));
    }

    public function update(Request $request, $id)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $adjustment = Adjustment::find($id);
        $rules = [
            "warehouse_id" => "required|integer",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",
            /*"waste.*" => "required",

            "qty.*" => "required_without:waste.*",
            "waste.*" => "required_without:qty.*",*/
        ];

        $message = [
            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",
            /*"waste.*.required" => "Waste is required",

            "qty.*.required_without" => "The Quantity field is required when Waste is not present.",
            "waste.*.required_without" => "The Waste field is required when Quantity is not present.",*/
        ];

        $validation =  Validator::make($request->all(),$rules,$message);
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            if(count($request->product_id) > 0){
                DB::beginTransaction();
                try {

                    $lims_adjustment_data = Adjustment::find($adjustment->id);
                    $lims_product_adjustment_data = ProductAdjustment::where('adjustment_id', $adjustment->id)->get();

                    foreach ($lims_product_adjustment_data as $product_adjustment_data) {
                        $old_qty_value   = $product_adjustment_data->qty;

                        $lims_product_data = Product::find($product_adjustment_data->product_id);

                        $lims_product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $product_adjustment_data->product_id],
                            ['warehouse_id', $lims_adjustment_data->warehouse_id],
                        ])->first();

                        if($product_adjustment_data->action == '-'){
                            $lims_product_data->qty += $old_qty_value;
                            $lims_product_warehouse_data->qty += $old_qty_value;
                        }
                        elseif($product_adjustment_data->action == '+'){
                            $lims_product_data->qty -= $old_qty_value;
                            $lims_product_warehouse_data->qty -= $old_qty_value;
                        }
                        $lims_product_data->save();
                        $lims_product_warehouse_data->save();

                        $product_adjustment_data->delete();
                    }

                    $adjustment->warehouse_id         = $request->warehouse_id;
                    $adjustment->item                 = count($request->product_id);
                    $adjustment->note                 = $request->note;
                    if ($request->hasFile('document')){
                        if($adjustment->file) @unlink($adjustment->document);
                        $purchase_document = OwnLibrary::uploadImage($request->document, "adjustment/document");
                        $adjustment->document = $purchase_document;
                    }
                    $adjustment->save();

                    $total_qty_input = 0;
                    $total_waste_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);

                        $quantity     = $request->qty[$i] ? $request->qty[$i] * $unit_data->value : 0 * $unit_data->value;

                        $product_warehouse_data = Product_Warehouse::where([
                            ['product_id', $request->product_id[$i]],
                            ['warehouse_id', $request->warehouse_id[$i] ],
                        ])->first();

                        if($request->action[$i] == '-'){
                            $product_data->qty -= $quantity;
                            $product_warehouse_data->qty -= $quantity;
                        }
                        elseif($request->action[$i] == '+'){
                            $product_data->qty += $quantity;
                            $product_warehouse_data->qty += $quantity;
                        }

                        $product_data->save();
                        $product_warehouse_data->save();

                        // Add to product purchase
                        $product_adjustment = new ProductAdjustment();
                        $product_adjustment->adjustment_id = $adjustment->id;
                        $product_adjustment->product_id = $request->product_id[$i];
                        $product_adjustment->qty = $request->qty[$i] * $unit_data->value;
                        $product_adjustment->action = $request->action[$i];

                        $product_adjustment->adjustment_unit_id = $request->unit_id[$i];
                        $product_adjustment->net_unit_cost      = $request->unit_price[$i];
                        $product_adjustment->total              = $request->qty[$i] * $request->unit_price[$i];

                        $product_adjustment->org_input        = $request->qty[$i];
                        $product_adjustment->unit_value       = $unit_data->value;

                        $product_adjustment->save();

                        $total_qty_input += $request->qty[$i] ? $request->qty[$i] * $unit_data->value : 0 * $unit_data->value;
                    }

                    $up_adjustment = Adjustment::find($adjustment->id);

                    $up_adjustment->total_qty        = $total_qty_input;
                    $up_adjustment->save();

                    DB::commit();
                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('stock-in')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }
            }
            session()->flash("success", 'Adjustment updated successfully.');
            return redirect()->route("qty_adjustment.index");
        }
        // End of new store process===========================================
        //====================================================================
    }

    public function adjustmentFileDownload($id){
        $id = $id;
        if($id){
            $adjustment = Adjustment::find($id);
            if($adjustment->document){
                $headers = ['Content-Type: application/pdf'];

                $a = str_replace('public/', '', $adjustment->document);
                $file= public_path().'/'. $a;

                $my_url = $adjustment->document;
                $fileName = substr($my_url, strrpos($my_url, '/' )+1);
                return response()->download($file, $fileName, $headers);
            }
        }else{
            echo "<h2>Not found</h2>";
        }
    }

    public function destroy(Request $request, $id)
    {
        OwnLibrary::validateAccess($this->moduleId,4);

        $adjustment = Adjustment::find($id);
        $lims_product_adjustment_data = ProductAdjustment::where('adjustment_id', $adjustment->id)->get();
        DB::beginTransaction();
        try {
            foreach ($lims_product_adjustment_data as $product_adjustment_data) {
                $old_qty_value   = $product_adjustment_data->qty;

                $lims_product_data = Product::find($product_adjustment_data->product_id);

                $lims_product_warehouse_data = Product_Warehouse::where([
                    ['product_id', $product_adjustment_data->product_id],
                    ['warehouse_id', $adjustment->warehouse_id],
                ])->first();

                if($product_adjustment_data->action == '-'){
                    $lims_product_data->qty += $old_qty_value;
                    $lims_product_warehouse_data->qty += $old_qty_value;
                }
                elseif($product_adjustment_data->action == '+'){
                    $lims_product_data->qty -= $old_qty_value;
                    $lims_product_warehouse_data->qty -= $old_qty_value;
                }
                $lims_product_data->save();
                $lims_product_warehouse_data->save();

                $product_adjustment_data->delete();
            }

            DB::commit();
        } catch (ValidationException $e) {
            DB::rollback();
            return Redirect::to('stock-in')
                ->withErrors($e->getErrors())
                ->withInput();
        } catch (\Exception $e) {
            DB::rollback();
            throw $e;
        }

        if ($adjustment->delete()){
            session()->flash("success","Adjustment deleted successfully");
            return redirect()->back();
        }else{
            session()->flash("error","Adjustment not deleted");
            return redirect()->back();
        }

    }

    public function getProduct(Request $request)
    {
        $id = $request->warehouse_id;
        $search = $request->search;

        $products = Product::join('product_warehouse','product_warehouse.product_id','=','products.id')
            ->select('products.id', DB::raw("CONCAT(code,' ','(',products.name,')') AS text"))
            ->where('product_warehouse.warehouse_id','=',$id);
        $products->where(function($query) use($search){
            $query->where('products.name','LIKE',"$search%");
            $query->orWhere('products.code','LIKE',"$search%");
        });

        $products = $products->limit(10)->get();
        return response()->json($products);
    }

    public function adjustment_product_warehouse_qty_get(Request $request){
        $product_id = $request->product_id;
        $product = Product::find($product_id);
        $unit = Unit::find($product->unit_id);

        $row = '';

        $row .= '<tr class="rows" id="">';
        $row .= '<td>'.$product->name.'</td>';
        $row .= '<td>'.$product->code.'</td>';
        $row .= '<td>'.$unit->name.'</td>';
        $row .= '<td>
                <input type="hidden" class="form-control product_id" name="product_id[]" value="'.$product->id.'" required="" autocomplete="off">
                <input type="number" class="form-control qty" name="qty[]" value="1" step="any" min="1" autocomplete="off">
            </td>';
        $row .= '
                <input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
                <input type="hidden" class="subtotal-input" name="subtotal_input[]" value="1">
                 ';
        $row .= '<td>
                    <select class="form-control" name="action[]" required>
                        <option value="">Select</option>
                        <option value="+">Addition</option>
                        <option value="-">Subtraction</option>
                    </select>
                </td>';
        $row .= '<td>
               <div>
                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                       <i class="far fa-trash-alt"></i>
                   </button>
               </div>
            </td>';
        $row .= '</tr>';

        return $row;
    }
}
