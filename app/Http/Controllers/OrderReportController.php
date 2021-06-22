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
                    );

        $purchases->where('purchases.status', 1);
        if($user_ware_house){
            $purchases->whereIn('purchases.warehouse_id', $user_ware_house);
        }
        if($request->input('start_date')){
            $reportUrl .= '&start_date='.$request->input('start_date');
            $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $reportUrl .= '&end_date='.$request->input('end_date');
            $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $purchases->where('purchases.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('supplier_ser')){
            $reportUrl .= '&supplier_ser='.$request->input('supplier_ser');
            $purchases->where('purchases.supplier_id','=', $request->input('supplier_ser'));
        }

        $purchases->orderBy('purchases.id','DESC');
        $purchases = $purchases->paginate(20);

        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();
        $suppliers = Supplier::select('id','name')->orderBy('name')->get();

        return view('backend.reports.index', compact('purchases', 'warehouses', 'suppliers', 'reportUrl'));
    }

    public function orderReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();
        $purchases = Product::join("product_purchases", "product_purchases.product_id","=","products.id")
            ->join("purchases", "purchases.id","=","product_purchases.purchase_id")
            ->join("warehouses", "warehouses.id","=","purchases.warehouse_id")
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
        );

        $purchases->where('purchases.status', 1);
        if($user_ware_house){
            $purchases->whereIn('purchases.warehouse_id', $user_ware_house);
        }
        if($request->input('start_date')){
            $purchases->whereDate('purchases.received_date','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $purchases->whereDate('purchases.received_date','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $purchases->where('purchases.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('supplier_ser')){
            $purchases->where('purchases.supplier_id','=', $request->input('supplier_ser'));
        }

        $purchases->orderBy('purchases.id','DESC');
        $purchases = $purchases->get();

        $fileName = 'order-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Order Date', 'Received Date', 'Reference', 'Warehouse', 'Supplier', 'Product Name'
        , 'Purchase Amount', 'Purchase Qty');

        $callback = function() use($purchases, $columns) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;
            foreach($purchases as $purchase) {
                fputcsv($file, array(++$sl, date("d/m/Y", strtotime($purchase->order_date))
                ,$purchase->received_date ? date("d/m/Y", strtotime($purchase->received_date)) : ''
                , $purchase->reference_no, $purchase->warehouse_name
                , $purchase->supplier_name, $purchase->product_name
                , number_format($purchase->purchases_amount, 2)
                , number_format($purchase->purchases_qty, 2) ) );
            }
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
