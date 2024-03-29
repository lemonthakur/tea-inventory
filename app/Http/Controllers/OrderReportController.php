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

class OrderReportController extends Controller
{
    protected $moduleId = 15;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();

        $reportUrl = \App::make('url')->to('/').'/order-report-excel?';
        $purchases = Product::join("product_purchases", "product_purchases.product_id","=","products.id")
                    ->join("purchases", "purchases.id","=","product_purchases.purchase_id")
                    ->join("warehouses", "warehouses.id","=","purchases.warehouse_id")
                    ->join("units", "units.id","=","product_purchases.purchase_unit_id")
                    ->leftjoin("suppliers", "suppliers.id","=","purchases.supplier_id");
                    $purchases->select(
                        'purchases.created_at as order_date'
                        ,'purchases.received_date as received_date'
                        , 'purchases.reference_no'
                        , 'warehouses.name as warehouse_name'
                        , 'suppliers.name as supplier_name'
                        , 'products.name as product_name'
                        , 'product_purchases.total as purchases_amount'
                        , 'product_purchases.qty as purchases_qty'
                        , 'products.qty as stock_qty'
                        , 'purchases.status as purchases_status'
                        , 'units.name as units_name'
                        , 'units.value as units_value'
                    );

        $purchases->where('purchases.status', 1);
        if($user_ware_house){
            $purchases->whereIn('purchases.warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $reportUrl .= '&product_ser='.$request->input('start_date');
            $purchases->where('product_purchases.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $reportUrl .= '&start_date='.$request->input('start_date');
            $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
            /*if($request->input('status_ser')){
                if($request->input('status_ser') == 1){
                    $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
                }else{
                    $purchases->whereDate('purchases.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
                }
            }
            else{
                $purchases->whereDate('purchases.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
            }*/

        }
        if($request->input('end_date')){
            $reportUrl .= '&end_date='.$request->input('end_date');
            $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
            /*if($request->input('status_ser')){
                if($request->input('status_ser') == 1){
                    $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
                }else{
                    $purchases->whereDate('purchases.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
                }
            }
            else{
                $purchases->whereDate('purchases.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
            }*/
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $purchases->where('purchases.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('supplier_ser')){
            $reportUrl .= '&supplier_ser='.$request->input('supplier_ser');
            $purchases->where('purchases.supplier_id','=', $request->input('supplier_ser'));
        }
        if($request->input('status_ser')){
            $reportUrl .= '&status_ser='.$request->input('status_ser');
            $purchases->where('purchases.status','=', $request->input('status_ser'));
        }

        $purchases->orderBy('purchases.id','DESC');

        $total_purchase_qty = $purchases->sum('product_purchases.qty');
        $total_price        = $purchases->sum('product_purchases.total');

        $purchases = $purchases->paginate(50);

        $warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();
        $suppliers = Supplier::select('id','name')->orderBy('name')->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';

        return view('backend.reports.index', compact('purchases', 'warehouses', 'suppliers', 'reportUrl'
            , 'total_purchase_qty', 'total_price', 'site_setting', 'site_unit'));
    }

    public function orderReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();

        $purchases = Product::join("product_purchases", "product_purchases.product_id","=","products.id")
            ->join("purchases", "purchases.id","=","product_purchases.purchase_id")
            ->join("warehouses", "warehouses.id","=","purchases.warehouse_id")
            ->join("units", "units.id","=","product_purchases.purchase_unit_id")
            ->leftjoin("suppliers", "suppliers.id","=","purchases.supplier_id");
        $purchases->select(
            'purchases.created_at as order_date'
            ,'purchases.received_date as received_date'
            , 'purchases.reference_no'
            , 'warehouses.name as warehouse_name'
            , 'suppliers.name as supplier_name'
            , 'products.name as product_name'
            , 'product_purchases.total as purchases_amount'
            , 'product_purchases.qty as purchases_qty'
            , 'products.qty as stock_qty'
            , 'purchases.status as purchases_status'
            , 'units.name as units_name'
            , 'units.value as units_value'
        );

        $purchases->where('purchases.status', 1);
        if($user_ware_house){
            $purchases->whereIn('purchases.warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $purchases->where('product_purchases.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
            /*if($request->input('status_ser')){
                if($request->input('status_ser') == 1){
                    $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
                }else{
                    $purchases->whereDate('purchases.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
                }
            }
            else{
                $purchases->whereDate('purchases.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
            }*/

        }
        if($request->input('end_date')){
            $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
            /*if($request->input('status_ser')){
                if($request->input('status_ser') == 1){
                    $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
                }else{
                    $purchases->whereDate('purchases.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
                }
            }
            else{
                $purchases->whereDate('purchases.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
            }*/

        }
        if($request->input('warehouse_ser')){
            $purchases->where('purchases.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('supplier_ser')){
            $purchases->where('purchases.supplier_id','=', $request->input('supplier_ser'));
        }
        if($request->input('status_ser')){
            $purchases->where('purchases.status','=', $request->input('status_ser'));
        }

        $purchases->orderBy('purchases.id','DESC');

        $total_purchase_qty = $purchases->sum('product_purchases.qty');
        $total_price        = $purchases->sum('product_purchases.total');
        $purchases = $purchases->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $fileName = 'order-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Order Date', 'Received Date', 'Reference', 'Warehouse', 'Supplier', 'Product Name'
        , 'Unit', 'Purchase Amount', 'Purchase Qty'/*, 'Status'*/);

        $callback = function() use($purchases, $columns, $total_purchase_qty, $total_price, $site_unit_val, $site_unit_name) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach($purchases as $purchase) {
                $status = ($purchase->purchases_status == 1) ? 'Received' : 'Pending';

                fputcsv($file, array(++$sl, date("d/m/Y", strtotime($purchase->order_date))
                ,$purchase->received_date ? date("d/m/Y", strtotime($purchase->received_date)) : ''
                , $purchase->reference_no
                , $purchase->warehouse_name
                , $purchase->supplier_name, $purchase->product_name
                , $purchase->units_name
                , number_format($purchase->purchases_amount, 2)
                , number_format($purchase->purchases_qty/$purchase->units_value, 2)
                /*, $status*/
                ) );
            }
            fputcsv($file, array('','','','','','','','Total',number_format($total_price, 2), number_format($total_purchase_qty/$site_unit_val, 2).' '.$site_unit_name));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
