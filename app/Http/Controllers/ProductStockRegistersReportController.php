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
use App\Models\SiteSetting;
use DB;
use Auth;
use Carbon\Carbon;

class ProductStockRegistersReportController extends Controller
{
    protected $moduleId = 15;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        $reportUrl = \App::make('url')->to('/').'/product-register-stock-report-excel?';

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;

        $products = Product::join('units', 'units.id' ,'=', 'products.unit_id');
        if($user_ware_house){
            $products->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
            $products->select(
                DB::raw("SUM(product_warehouse.qty) as qty")
                , 'products.id'
                , 'products.name'
                , 'products.code'
                , 'products.barcode_symbology'
                , 'products.brand_id'
                , 'products.category_id'
                , 'products.unit_id'
                , 'products.product_price'
                //, 'products.qty'
                , 'products.waste_qty'
                , 'products.alert_quantity'
                , 'products.image'
                , 'products.file'
                , 'products.product_details'
                , 'products.status'
                , 'products.deleted_at'
                , 'products.created_by'
                , 'products.updated_by'
                , 'products.created_at'
                , 'products.updated_at'
                , 'units.value as unit_value'
                , DB::raw("(SUM(product_warehouse.qty)/units.value)*products.product_price as total")
            );
            $products->whereIn('product_warehouse.warehouse_id', $user_ware_house);
        }
        else{
            if($request->input('warehouse_ser')){
                $products->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
                $products->select(
                    DB::raw("SUM(product_warehouse.qty) as qty")
                    , 'products.id'
                    , 'products.name'
                    , 'products.code'
                    , 'products.barcode_symbology'
                    , 'products.brand_id'
                    , 'products.category_id'
                    , 'products.unit_id'
                    , 'products.product_price'
                    //, 'products.qty'
                    , 'products.waste_qty'
                    , 'products.alert_quantity'
                    , 'products.image'
                    , 'products.file'
                    , 'products.product_details'
                    , 'products.status'
                    , 'products.deleted_at'
                    , 'products.created_by'
                    , 'products.updated_by'
                    , 'products.created_at'
                    , 'products.updated_at'
                    , 'units.value as unit_value'
                    , DB::raw("(SUM(product_warehouse.qty)/units.value)*products.product_price as total")
                );
            }else{
                $products->leftjoin('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
                $products->select(
                    'products.id'
                    , 'products.name'
                    , 'products.code'
                    , 'products.barcode_symbology'
                    , 'products.brand_id'
                    , 'products.category_id'
                    , 'products.unit_id'
                    , 'products.product_price'
                    , 'products.qty'
                    , 'products.waste_qty'
                    , 'products.alert_quantity'
                    , 'products.image'
                    , 'products.file'
                    , 'products.product_details'
                    , 'products.status'
                    , 'products.deleted_at'
                    , 'products.created_by'
                    , 'products.updated_by'
                    , 'products.created_at'
                    , 'products.updated_at'
                    , 'units.value as unit_value'
                    , DB::raw("(SUM(products.qty)/units.value)*products.product_price as total")
                );
            }

        }

        if($request->input('product_ser')){
            $reportUrl .= '&product_ser='.$request->input('start_date');
            $products->where('products.id', $request->input('product_ser'));
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $products->where('product_warehouse.warehouse_id','=', $request->input('warehouse_ser'));
        }
        $products->groupBy('products.id');

        if($request->input('order_by_ser')){
            if($request->order_by_ser == 'alert_quantity'){
                $products->having('qty', '<=', $site_setting->alert_quantity/$site_unit_val);
                $products->orderBy('qty', 'asc');
            }else{
                $products->orderBy('qty', $request->input('order_by_ser'));
            }
            $reportUrl .= '&order_by_ser='.$request->input('order_by_ser');
        }else{
            $products->orderBy('products.name','asc');
        }

        /*if($request->input('order_by_ser')){
            $products->orderBy('qty', $request->input('order_by_ser'));
        }else{
            $products->orderBy('products.name','asc');
        }*/
        $products  = $products->paginate(20);

        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';

        return view('backend.reports.product-stock-register-report', compact('products', 'warehouses', 'reportUrl', 'site_setting', 'site_unit'
            , 'user_ware_house'));
    }

    public function productRegisterStockReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;

        $products = Product::join('units', 'units.id' ,'=', 'products.unit_id');
        if($user_ware_house){
            $products->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
            $products->select(
                DB::raw("SUM(product_warehouse.qty) as qty")
                , 'products.id'
                , 'products.name'
                , 'products.code'
                , 'products.barcode_symbology'
                , 'products.brand_id'
                , 'products.category_id'
                , 'products.unit_id'
                , 'products.product_price'
                //, 'products.qty'
                , 'products.waste_qty'
                , 'products.alert_quantity'
                , 'products.image'
                , 'products.file'
                , 'products.product_details'
                , 'products.status'
                , 'products.deleted_at'
                , 'products.created_by'
                , 'products.updated_by'
                , 'products.created_at'
                , 'products.updated_at'
                , 'units.value as unit_value'
                , DB::raw("(SUM(product_warehouse.qty)/units.value)*products.product_price as total")
            );
            $products->whereIn('product_warehouse.warehouse_id', $user_ware_house);
        }
        else{
            if($request->input('warehouse_ser')){
                $products->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
                $products->select(
                    DB::raw("SUM(product_warehouse.qty) as qty")
                    , 'products.id'
                    , 'products.name'
                    , 'products.code'
                    , 'products.barcode_symbology'
                    , 'products.brand_id'
                    , 'products.category_id'
                    , 'products.unit_id'
                    , 'products.product_price'
                    //, 'products.qty'
                    , 'products.waste_qty'
                    , 'products.alert_quantity'
                    , 'products.image'
                    , 'products.file'
                    , 'products.product_details'
                    , 'products.status'
                    , 'products.deleted_at'
                    , 'products.created_by'
                    , 'products.updated_by'
                    , 'products.created_at'
                    , 'products.updated_at'
                    , 'units.value as unit_value'
                    , DB::raw("(SUM(product_warehouse.qty)/units.value)*products.product_price as total")
                );
            }else{
                $products->leftjoin('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
                $products->select(
                    'products.id'
                    , 'products.name'
                    , 'products.code'
                    , 'products.barcode_symbology'
                    , 'products.brand_id'
                    , 'products.category_id'
                    , 'products.unit_id'
                    , 'products.product_price'
                    , 'products.qty'
                    , 'products.waste_qty'
                    , 'products.alert_quantity'
                    , 'products.image'
                    , 'products.file'
                    , 'products.product_details'
                    , 'products.status'
                    , 'products.deleted_at'
                    , 'products.created_by'
                    , 'products.updated_by'
                    , 'products.created_at'
                    , 'products.updated_at'
                    , 'units.value as unit_value'
                    , DB::raw("(SUM(products.qty)/units.value)*products.product_price as total")
                );
            }

        }

        if($request->input('product_ser')){
            $products->where('products.id', $request->input('product_ser'));
        }
        if($request->input('warehouse_ser')){
            $products->where('product_warehouse.warehouse_id','=', $request->input('warehouse_ser'));
        }
        $products->groupBy('products.id');

        if($request->input('order_by_ser')){
            if($request->order_by_ser == 'alert_quantity'){
                $products->having('qty', '<=', $site_setting->alert_quantity/$site_unit_val);
                $products->orderBy('qty', 'asc');
            }else{
                $products->orderBy('qty', $request->input('order_by_ser'));
            }
        }else{
            $products->orderBy('products.name','asc');
        }

        if($request->input('page')){
            if($request->input('page')==1)
                $page = 20*(0*$request->input('page'));
            else
                $page = $page = 20*($request->input('page')-1);

            $products  = $products->skip($page)->take(20)->get();
        }else{
            $products  = $products->paginate(20);
        }

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $fileName = 'product-stock-register-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Code', 'Name', 'Order Qty', 'Transfer In', 'Transfer Out'
                        , 'Adjust Addition'
                        , 'Adjust Subtraction'
                        , 'Production'
                        , 'Used in Production'
                        , 'In Stock'
                        );

        $callback = function() use($products, $columns, $site_unit_val, $site_unit_name, $user_ware_house) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            $total_order_qty = 0;
            $total_transfer_in_qty = 0;
            $total_transfer_out_qty = 0;
            $total_adjust_in_qty = 0;
            $total_adjust_out_qty = 0;
            $total_production_qty = 0;
            $total_used_in_production_qty = 0;

            foreach($products as $product) {

                // order
                $order = \App\Models\ProductPurchase::join('purchases', 'purchases.id','=','product_purchases.purchase_id')
                    ->where('product_purchases.product_id', $product->id);
                if($user_ware_house)
                    $order->whereIn('warehouse_id', $user_ware_house);
                if(request()->query('purchases.warehouse_ser'))
                    $order->where('warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $order->whereDate('product_purchases.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $order->whereDate('product_purchases.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $order_qty = $order->sum('product_purchases.qty');
                $total_order_qty += $order_qty;

                // tranfer in
                $transfer_in = \App\Models\ProductTransfer::join('transfers', 'transfers.id','=','product_transfer.transfer_id')
                    ->where('product_id', $product->id);
                if($user_ware_house)
                    $transfer_in->whereIn('to_warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $transfer_in->where('to_warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $transfer_in->whereDate('product_transfer.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $transfer_in->whereDate('product_transfer.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $transfer_in_qty = $transfer_in->sum('product_transfer.qty');
                if(request()->query('warehouse_ser') || $user_ware_house)
                    $total_transfer_in_qty += $transfer_in_qty;
                else
                    $total_transfer_in_qty = $transfer_in_qty = 0;

                // transfer out
                $transfer_out = \App\Models\ProductTransfer::join('transfers', 'transfers.id','=','product_transfer.transfer_id')
                    ->where('product_id', $product->id);
                if($user_ware_house)
                    $transfer_out->whereIn('from_warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $transfer_out->where('from_warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $transfer_out->whereDate('product_transfer.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $transfer_out->whereDate('product_transfer.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $transfer_out_qty = $transfer_out->sum('qty');
                if(request()->query('warehouse_ser') || $user_ware_house)
                    $total_transfer_out_qty += $transfer_out_qty;
                else
                    $total_transfer_out_qty = $transfer_out_qty = 0;

                // adjut in
                $adjust_in = \App\Models\ProductAdjustment::join('adjustments', 'adjustments.id','=','product_adjustments.adjustment_id')
                    ->where('product_id', $product->id)
                    ->where('action', '+');
                if($user_ware_house)
                    $adjust_in->whereIn('warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $adjust_in->where('warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $adjust_in->whereDate('product_adjustments.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $adjust_in->whereDate('product_adjustments.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $adjust_in_qty = $adjust_in->sum('product_adjustments.qty');
                $total_adjust_in_qty += $adjust_in_qty;

                // adjust out
                $adjust_out = \App\Models\ProductAdjustment::join('adjustments', 'adjustments.id','=','product_adjustments.adjustment_id')
                    ->where('product_id', $product->id)
                    ->where('action', '-');
                if($user_ware_house)
                    $adjust_out->whereIn('warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $adjust_out->where('warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $adjust_out->whereDate('product_adjustments.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $adjust_out->whereDate('product_adjustments.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $adjust_out_qty = $adjust_out->sum('product_adjustments.qty');
                $total_adjust_out_qty += $adjust_out_qty;

                // production
                $production = \App\Models\Production::where('status', 1)
                    ->where('product_id', $product->id);
                if($user_ware_house)
                    $production->whereIn('warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $production->where('warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $production->whereDate('created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $production->whereDate('created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $production_qty = $production->sum('produce_amount');
                $total_production_qty += $production_qty;

                // unsed in production
                $used_in_production = \App\Models\ProductionUseProduct::whereNotNull('id')
                    ->where('product_id', $product->id);
                if($user_ware_house)
                    $used_in_production->whereIn('warehouse_id', $user_ware_house);
                if(request()->query('warehouse_ser'))
                    $used_in_production->where('warehouse_id','=', request()->query('warehouse_ser'));
                if(request()->query('start_date'))
                    $used_in_production->whereDate('created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                if(request()->query('end_date'))
                    $used_in_production->whereDate('created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                $used_in_production_qty = $used_in_production->sum('qty');
                $total_used_in_production_qty += $used_in_production_qty;

                fputcsv($file, array(++$sl
                , $product->code
                , $product->name
                , number_format($order_qty/$product->unit_value, 2)
                , number_format($transfer_in_qty/$product->unit_value, 2)
                , number_format($transfer_out_qty/$product->unit_value, 2)
                , number_format($adjust_in_qty/$product->unit_value, 2)
                , number_format($adjust_out_qty/$product->unit_value, 2)
                , number_format($production_qty/$product->unit_value, 2)
                , number_format($used_in_production_qty/$product->unit_value, 2)
                , number_format((($order_qty+$transfer_in_qty+$adjust_in_qty+$production_qty) - ($transfer_out_qty+$adjust_out_qty+$used_in_production_qty))/$site_unit_val, 2)
                ) );
            }
            fputcsv($file, array('','','Total'
                    , number_format($total_order_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_transfer_in_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_transfer_out_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_adjust_in_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_adjust_out_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_production_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format($total_used_in_production_qty/$site_unit_val, 2).' '.$site_unit_name
                    , number_format((($total_order_qty+$total_transfer_in_qty+$total_adjust_in_qty+$total_production_qty) -
                    ($total_transfer_out_qty+$total_adjust_out_qty+$total_used_in_production_qty))/$site_unit_val, 2).' '.$site_unit_name
                ));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
