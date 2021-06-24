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

class ProductStockReportController extends Controller
{
    protected $moduleId = 15;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        $reportUrl = \App::make('url')->to('/').'/product-stock-report-excel?';

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
        }else{
            $products->orderBy('products.name','asc');
        }

        $for_total_price    = $products->get();
        $total_qty          = $for_total_price->sum('qty');
        $total_price        = $for_total_price->sum('total');

        $products           = $products->paginate(50);

        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        return view('backend.reports.product-stock-report', compact('products', 'warehouses', 'reportUrl'
            , 'total_qty', 'total_price', 'site_setting', 'site_unit'));
    }

    public function productStockReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();

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
            $products->orderBy('qty', $request->input('order_by_ser'));
        }else{
            $products->orderBy('products.name','asc');
        }

        $for_total_price    = $products->get();
        $total_qty          = $for_total_price->sum('qty');
        $total_price        = $for_total_price->sum('total');

        $products           = $products->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $fileName = 'product-stock-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Code', 'Name', 'Unit Price', 'Current Stock', 'Stock Value');

        $callback = function() use($products, $columns, $total_qty, $total_price, $site_unit_val, $site_unit_name) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach($products as $product) {

                fputcsv($file, array(++$sl
                , $product->code
                , $product->name
                , $product->product_price
                , number_format($product->qty/$product->unit_value, 2)
                , number_format($product->total, 2)
                ) );
            }
            fputcsv($file, array('','','','Total', number_format($total_qty/$site_unit_val, 2).' '.$site_unit_name, number_format($total_price, 2) ));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
