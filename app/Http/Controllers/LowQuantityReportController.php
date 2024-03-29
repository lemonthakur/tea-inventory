<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Product_Warehouse;
use App\Models\Unit;
use App\Models\SiteSetting;
use App\Models\Warehouse;
use Illuminate\Http\Request;

class LowQuantityReportController extends Controller
{
    public function index(Request $request){

        $user_ware_house = OwnLibrary::user_warehosue();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;

        $products = Product_Warehouse::select(
            'product_warehouse.id as product_warehouse_id',
            'product_warehouse.qty as product_warehouse_qty',
            'product_warehouse.warehouse_id as warehouse_id'
,            'products.id as product_id',
            'products.name as product_name',
            'units.name as unit_name',
            'warehouses.name as warehouse_name',
        )
            ->join("products", "product_warehouse.product_id","=","products.id")
            ->join("units", "products.unit_id","=","units.id")
            ->join("warehouses", "product_warehouse.warehouse_id","=","warehouses.id");
        if($request->order_by){
            if($request->order_by == 'alert_quantity'){
                $products->where('product_warehouse.qty', '<=', $site_setting->alert_quantity/$site_unit_val);
                $products->orderBy('product_warehouse_qty', 'asc');
            }else{
                $products->orderBy('product_warehouse_qty',$request->order_by ?? 'asc');
            }
        }else{
            $products->orderBy('product_warehouse_qty',$request->order_by ?? 'asc');
        }

        if ($request->quantity){
            $products->where('product_warehouse.qty','<=',$request->quantity);
        }

        if ($request->product_ser){
            $products->where('product_id', $request->product_ser);
        }

        if ($request->warehouse_ser){
            $products->where('warehouse_id', $request->warehouse_ser);
        }

        if($user_ware_house){
            $products->whereIn('warehouse_id', $user_ware_house);
        }


       $products = $products->paginate(20);

        $warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        return view('backend.low-quantity-report.index',compact('products','warehouses',
            'site_setting', 'site_unit'));
    }

    public function excel(Request $request){
        $siteSetting = SiteSetting::select('alert_quantity')->find(1);
        $user_ware_house = OwnLibrary::user_warehosue();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;

        $products = Product_Warehouse::select(
            'product_warehouse.id as product_warehouse_id',
            'product_warehouse.qty as product_warehouse_qty',
            'product_warehouse.warehouse_id as warehouse_id'
            ,            'products.id as product_id',
            'products.name as product_name',
            'units.name as unit_name',
            'warehouses.name as warehouse_name',
        )
            ->join("products", "product_warehouse.product_id","=","products.id")
            ->join("units", "products.unit_id","=","units.id")
            ->join("warehouses", "product_warehouse.warehouse_id","=","warehouses.id");
        if($request->order_by){
            if($request->order_by == 'alert_quantity'){
                $products->where('product_warehouse.qty', '<=', $site_setting->alert_quantity/$site_unit_val);
                $products->orderBy('product_warehouse_qty', 'asc');
            }else{
                $products->orderBy('product_warehouse_qty',$request->order_by ?? 'asc');
            }
        }else{
            $products->orderBy('product_warehouse_qty',$request->order_by ?? 'asc');
        }

        if ($request->quantity){
            $products->where('product_warehouse.qty','<=',$request->quantity);
        }

        if ($request->product_ser){
            $products->where('product_id', $request->product_ser);
        }

        if ($request->warehouse_ser){
            $products->where('warehouse_id', $request->warehouse_ser);
        }

        if($user_ware_house){
            $products->whereIn('warehouse_id', $user_ware_house);
        }
        $products = $products->get();

        $fileName = 'low quantity product-'.date('d/m/Y H:i a').'.csv';

        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL','Product Name', 'Qty', 'Unit', 'Warehouse');

        $callback = function() use($products, $columns) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach ($products as $product) {
                $row['SL']  = $sl++;
                $row['Product Name']  = $product->product_name;
                $row['Qty']    = number_format($product->product_warehouse_qty, 2);
                $row['Unit']    = $product->unit_name;
                $row['Warehouse']  = ucwords($product->warehouse_name);

                fputcsv($file, array($row['SL'],$row['Product Name'], $row['Qty'], $row['Unit'], $row['Warehouse']));
            }

            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }

    public function print(Request $request){
        $siteSetting = SiteSetting::select('alert_quantity')->find(1);
        $user_ware_house = OwnLibrary::user_warehosue();

        $products = Product_Warehouse::select(
            'product_warehouse.id as product_warehouse_id',
            'product_warehouse.qty as product_warehouse_qty',
            'product_warehouse.warehouse_id as warehouse_id'
            ,            'products.id as product_id',
            'products.name as product_name',
            'units.name as unit_name',
            'warehouses.name as warehouse_name',
        )
            ->orderBy('product_warehouse_qty',$request->order_by ?? 'asc')
            ->join("products", "product_warehouse.product_id","=","products.id")
            ->join("units", "products.unit_id","=","units.id")
            ->join("warehouses", "product_warehouse.warehouse_id","=","warehouses.id")
            ->where('product_warehouse.qty','<=',$siteSetting->alert_quantity);

        if ($request->product_ser){
            $products->where('product_id', $request->product_ser);
        }

        if ($request->warehouse_ser){
            $products->where('warehouse_id', $request->warehouse_ser);
        }

        if($user_ware_house){
            $products->whereIn('warehouse_id', $user_ware_house);
        }
        $products = $products->get();
        return view('backend.low-quantity-report.print',compact('products'));
    }

}
