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
use DB;
use Auth;

class PurchaseController extends Controller
{
    protected $moduleId = 1;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        /*if(Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->where('user_id', Auth::id())->get();
        else
            $lims_purchase_list = Purchase::orderBy('id', 'desc')->get();*/

        $user_ware_house = OwnLibrary::user_warehosue();
        $purchases = Purchase::whereNotNull('id');
        if($user_ware_house){
            $purchases->whereIn('warehouse_id', $user_ware_house);
        }
        if($request->order_no){
            $purchases->where('reference_no', 'like', '%' . $request->order_no . '%');
        }
        if($request->barcode){
            $value = explode('~', $request->barcode);
            $product_id = $value[0];
            $purchase_id = $value[1];
            $reference_no = (isset($value[2])) ? $value[2] : '';

            $purchases->whereHas('purchase_details', function($query) use($product_id, $purchase_id, $reference_no) {
                $query->where('purchase_id', $purchase_id);
                $query->where('product_id', $product_id);
            });
            $purchases->where('reference_no', $reference_no);


        }
        $purchases->orderBy('id','DESC');
        $purchases = $purchases->paginate(20);

        return view('backend.purchase.index', compact('purchases'));
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

        $suppliers = Supplier::select('id','name')->orderBy('name')->get();
        return view('backend.purchase.create',compact('warehouses','suppliers'));
    }

    public function store(Request $request)
    {
        $rules = [
            "warehouse" => "required|integer",
            "reference_no" => "required|unique:purchases",
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
        ];

        $message = [
            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",

            "reference_no.required" => "Order no. is required",
            "reference_no.unique" => "The order no has already been taken.",
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
                    $purchase = new Purchase();

                    $reference_no = 'pr-' . date("Ymd") . '-'. date("his");

                    $purchase->reference_no         = $request->reference_no;
                    $purchase->user_id              = Auth::user()->id;
                    $purchase->warehouse_id         = $request->warehouse;
                    $purchase->supplier_id          = $request->supplier;
                    $purchase->item                 = count($request->product_id);

                    $purchase->total_qty            = 0;

                    $purchase->total_cost           = $request->total_price_input;
                    $purchase->grand_total          = $request->total_price_input;
                    $purchase->status  = $request->status;
                    $purchase->note  = $request->note;

                    if ($request->hasFile('document')){
                        $purchase_document = OwnLibrary::uploadImage($request->document, "purchase/document");
                        $purchase->document = $purchase_document;
                    }
                    $purchase->save();

                    $total_qty_input = 0;
                    $total_waste_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;

                        // if order receive
                        if($purchase->status == 1) {
                            $product_data->qty = $product_data->qty + $quantity;
                            $product_data->save();

                            $product_warehouse_data = Product_Warehouse::where([
                                ['product_id', $request->product_id[$i]],
                                ['warehouse_id', $request->warehouse],
                            ])->first();

                            //add quantity to warehouse
                            if ($product_warehouse_data) {
                                $product_warehouse_data->qty = $product_warehouse_data->qty + $quantity;
                            } else {
                                $product_warehouse_data = new Product_Warehouse();
                                $product_warehouse_data->product_id = $request->product_id[$i];
                                $product_warehouse_data->warehouse_id = $request->warehouse;
                                $product_warehouse_data->qty = $quantity;
                            }
                            $product_warehouse_data->save();
                        }

                        // Add to product purchase
                        $product_purchase               = new ProductPurchase();
                        $product_purchase->purchase_id  = $purchase->id ;
                        $product_purchase->product_id   = $request->product_id[$i];
                        $product_purchase->qty          = $request->qty[$i] * $unit_data->value;
                        $product_purchase->purchase_unit_id = $request->unit_id[$i];
                        $product_purchase->net_unit_cost    = $request->unit_price[$i];
                        $product_purchase->total            = $request->subtotal_input[$i];
                        $product_purchase->org_input        = $request->qty[$i];
                        $product_purchase->unit_value       = $unit_data->value;
                        $product_purchase->save();

                        $total_qty_input += $request->qty[$i] * $unit_data->value;
                    }

                    $up_purchase = Purchase::find($purchase->id);
                    $up_purchase->total_qty        = $total_qty_input;

                    $up_purchase->save();
                    DB::commit();
                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('order')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }
            }

            session()->flash("success", 'Order created successfully.');
            return redirect()->route("order.index");
        }
        // End of new store process===========================================
        //====================================================================

    }

    public function edit(Request $request, $id)
    {
        OwnLibrary::validateAccess($this->moduleId,3);

        $purchase = Purchase::find($id);
        $user_ware_house = OwnLibrary::user_warehosue();
        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        $suppliers = Supplier::select('id','name')->orderBy('name')->get();
        $product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();

        return view('backend.purchase.edit',compact('purchase', 'warehouses', 'suppliers', 'product_purchase_data'));
    }

    public function update(Request $request, $id)
    {
        $purchase = Purchase::find($id);
        $rules = [
            "warehouse" => "required|integer",
            "reference_no" => "required|unique:purchases,reference_no,".$id,
            "document" => "mimes:jpg,jpeg,png,gif,pdf,csv,docx,xlsx,txt",
            "product_id.*" => "required|integer",
            "qty.*" => "required",
            "subtotal_input.*" => "required",

            "total_qty_input" => "required",
            "total_price_input" => "required",
        ];

        $message = [
            "product_id.*.required" => "Product is required",
            "qty.*.required" => "Quantity is required",

            "reference_no.required" => "Order no. is required",
            "reference_no.unique" => "The order no has already been taken.",
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

                    $lims_purchase_data = Purchase::find($purchase->id);
                    $lims_product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();
                    foreach ($lims_product_purchase_data as $product_purchase_data) {

                        $old_qty_value   = $product_purchase_data->qty;

                        $lims_purchase_unit_data = Unit::find($product_purchase_data->purchase_unit_id);
                        $lims_product_data = Product::find($product_purchase_data->product_id);

                        if($purchase->status==1) {
                            $lims_product_warehouse_data = Product_Warehouse::where([
                                ['product_id', $product_purchase_data->product_id],
                                ['warehouse_id', $lims_purchase_data->warehouse_id],
                            ])->first();

                            $lims_product_data->qty -= $old_qty_value;
                            $lims_product_data->save();

                            $lims_product_warehouse_data->qty -= $old_qty_value;
                            $lims_product_warehouse_data->save();
                        }
                        $product_purchase_data->delete();
                    }

                    $purchase->reference_no         = $request->reference_no;
                    $purchase->warehouse_id         = $request->warehouse;
                    $purchase->supplier_id          = $request->supplier;
                    $purchase->item                 = count($request->product_id);

                    $purchase->total_qty            = 0;

                    $purchase->total_cost           = $request->total_price_input;
                    $purchase->grand_total          = $request->total_price_input;
                    $purchase->status  = 1;
                    $purchase->note  = $request->note;


                    $purchase->save();

                    $total_qty_input = 0;
                    for ($i = 0; count($request->product_id) > $i; $i++) {
                    
                        $product_data = Product::find($request->product_id[$i]);
                        $unit_data    = Unit::find($request->unit_id[$i]);
                        $quantity     = $request->qty[$i] * $unit_data->value;

                        //add quantity to warehouse
                        if($request->status == 1) {
                            $product_data->qty = $product_data->qty + $quantity;
                            $product_data->save();

                            $product_warehouse_data = Product_Warehouse::where([
                                ['product_id', $request->product_id[$i]],
                                ['warehouse_id', $request->warehouse ],
                            ])->first();

                            if ($product_warehouse_data) {
                                $product_warehouse_data->qty = $product_warehouse_data->qty + $quantity;
                            } else {
                                $product_warehouse_data = new Product_Warehouse();
                                $product_warehouse_data->product_id = $request->product_id[$i];
                                $product_warehouse_data->warehouse_id = $request->warehouse;
                                $product_warehouse_data->qty = $quantity;
                            }
                            $product_warehouse_data->save();
                        }

                        // Add to product purchase
                        $product_purchase = new ProductPurchase();
                        $product_purchase->purchase_id = $purchase->id;
                        $product_purchase->product_id = $request->product_id[$i];
                        $product_purchase->qty = $request->qty[$i] * $unit_data->value;
                        $product_purchase->purchase_unit_id = $request->unit_id[$i];
                        $product_purchase->net_unit_cost = $request->unit_price[$i];
                        $product_purchase->total = $request->subtotal_input[$i];
                        $product_purchase->org_input        = $request->qty[$i];
                        $product_purchase->unit_value       = $unit_data->value;
                        $product_purchase->save();
                        $total_qty_input += $request->qty[$i] * $unit_data->value;
                    }
                
                    $up_purchase = Purchase::find($purchase->id);
                    $up_purchase->total_qty        = $total_qty_input;
                    $up_purchase->status        = $request->status;
                    $up_purchase->save();

                    DB::commit();
                } catch (ValidationException $e) {
                    DB::rollback();
                    return Redirect::to('order')
                        ->withErrors($e->getErrors())
                        ->withInput();
                } catch (\Exception $e) {
                    DB::rollback();
                    throw $e;
                }
            }

            session()->flash("success", 'Order updated successfully.');
            return redirect()->route("order.index");
        }
        // End of new store process===========================================
        //====================================================================
    }

    public function orderReceived($id){
        if($id){
            DB::beginTransaction();
            try {
                $purchase = Purchase::find($id);
                $purchase_items = ProductPurchase::where('purchase_id', $id)->get();

                foreach ($purchase_items as $k => $v) {
                    $product_data = Product::find($v->product_id);
                    $unit_data    = Unit::find($product_data->unit_id);

                    $product_data->qty = $product_data->qty + $v->qty;
                    $product_data->save();

                    $product_warehouse_data = Product_Warehouse::where([
                        ['product_id', $v->product_id],
                        ['warehouse_id', $purchase->warehouse_id],
                    ])->first();

                    //add quantity to warehouse
                    if ($product_warehouse_data) {
                        $product_warehouse_data->qty = $product_warehouse_data->qty + $v->qty;
                    } else {
                        $product_warehouse_data = new Product_Warehouse();
                        $product_warehouse_data->product_id = $v->product_id;
                        $product_warehouse_data->warehouse_id = $purchase->warehouse_id;
                        $product_warehouse_data->qty = $v->qty;
                    }
                    $product_warehouse_data->save();
                }
                $purchase->status = 1;
                $purchase->save();

                DB::commit();
            } catch (ValidationException $e) {
                DB::rollback();
                return Redirect::to('order')
                    ->withErrors($e->getErrors())
                    ->withInput();
            } catch (\Exception $e) {
                DB::rollback();
                throw $e;
            }
            session()->flash("success", 'Status change successfully.');
            return redirect()->route("order.index");
        }else{
            session()->flash("error", 'Something went wrong. Please contact your technical person.');
            return redirect()->route("order.index");
        }
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
                            $html .='<td class="text-right">'.$product_purchase_data->net_unit_cost.'</td>';
                            $html .='<td class="text-right">'.$product_purchase_data->total.'</td>';
                        $html .='</tr>';
                    }

            $html .='<tr>';
                $html .='<td colspan="4"><strong>Total</strong></td>';
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

    public function deleteBySelection(Request $request)
    {
        $purchase_id = $request['purchaseIdArray'];
        foreach ($purchase_id as $id) {
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
        }
        return 'Purchase deleted successfully!';
    }

    public function destroy(Request $request, $id)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        
        $purchase = Purchase::find($id);
        $lims_product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();
        DB::beginTransaction();
        try { 
            foreach ($lims_product_purchase_data as $product_purchase_data) {
                $lims_purchase_unit_data = Unit::find($product_purchase_data->purchase_unit_id);
                
                $old_qty_value   = $product_purchase_data->qty;
                $lims_product_data = Product::find($product_purchase_data->product_id);

                if($purchase->status == 1) {
                    $lims_product_warehouse_data = Product_Warehouse::where([
                        ['product_id', $product_purchase_data->product_id],
                        ['warehouse_id', $purchase->warehouse_id],
                    ])->first();

                    $lims_product_data->qty -= $old_qty_value;
                    $lims_product_data->save();

                    $lims_product_warehouse_data->qty -= $old_qty_value;
                    $lims_product_warehouse_data->save();
                }
                $product_purchase_data->delete();
            }
            DB::commit();
        } catch (ValidationException $e) {
            DB::rollback();
            return Redirect::to('order')
                ->withErrors($e->getErrors())
                ->withInput();
        } catch (\Exception $e) {
            DB::rollback();
            throw $e;
        }

        if ($purchase->delete()){
            session()->flash("success","Purchase deleted successfully");
            return redirect()->back();
        }else{
            session()->flash("error","Purchase not deleted");
            return redirect()->back();
        }

    }

    public function orderLabel ($id){
        $purchase = Purchase::find($id);
        $lims_product_purchase_data = ProductPurchase::where('purchase_id', $purchase->id)->get();

        return view('backend.purchase.order_label', compact('purchase', 'lims_product_purchase_data'));
    }
}
