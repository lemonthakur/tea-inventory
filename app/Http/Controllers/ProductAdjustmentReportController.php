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
use App\Models\Adjustment;
use App\Models\ProductAdjustment;
use App\Models\Product_Warehouse;
use App\Models\User;
use App\Models\SiteSetting;
use DB;
use Auth;
use Carbon\Carbon;

class ProductAdjustmentReportController extends Controller
{
    protected $moduleId = 15;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();

        $reportUrl = \App::make('url')->to('/').'/product-adjustment-excel?';
        $adjustments = Product::join("product_adjustments", "product_adjustments.product_id","=","products.id")
                    ->join("adjustments", "adjustments.id","=","product_adjustments.adjustment_id")
                    ->join("warehouses", "warehouses.id","=","adjustments.warehouse_id")
                    ->join("units", "units.id","=","product_adjustments.adjustment_unit_id");
                    $adjustments->select(
                        'adjustments.created_at as adjustments_date'
                        , 'adjustments.reference_no'
                        , 'warehouses.name as warehouse_name'
                        , 'products.name as product_name'
                        , 'product_adjustments.total as adjustments_amount'
                        , 'product_adjustments.qty as adjustments_qty'
                        , 'products.qty as stock_qty'
                        , 'units.name as units_name'
                        , 'units.value as units_value'
                        , 'product_adjustments.action as action'
                    );

        if($user_ware_house){
            $adjustments->whereIn('adjustments.warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $reportUrl .= '&product_ser='.$request->input('start_date');
            $adjustments->where('product_adjustments.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $reportUrl .= '&start_date='.$request->input('start_date');
            $adjustments->whereDate('adjustments.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $reportUrl .= '&end_date='.$request->input('end_date');
            $adjustments->whereDate('adjustments.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $adjustments->where('adjustments.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('action_ser')){
            $reportUrl .= '&action_ser='.$request->input('action_ser');
            $adjustments->where('product_adjustments.action','=', $request->input('action_ser'));
        }
        $adjustments->orderBy('adjustments.created_at','DESC');

        $total_adjustment_qty = $adjustments->sum('product_adjustments.qty');
        $total_price          = $adjustments->sum('product_adjustments.total');

        $adjustments = $adjustments->paginate(50);

        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';

        return view('backend.reports.adjustment-report', compact('adjustments', 'warehouses', 'reportUrl'
            , 'total_adjustment_qty', 'total_price', 'site_setting', 'site_unit'));
    }

    public function productAdjustmentkReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();

        $reportUrl = \App::make('url')->to('/').'/product-adjustment-excel?';
        $adjustments = Product::join("product_adjustments", "product_adjustments.product_id","=","products.id")
            ->join("adjustments", "adjustments.id","=","product_adjustments.adjustment_id")
            ->join("warehouses", "warehouses.id","=","adjustments.warehouse_id")
            ->join("units", "units.id","=","product_adjustments.adjustment_unit_id");
        $adjustments->select(
            'adjustments.created_at as adjustments_date'
            , 'adjustments.reference_no'
            , 'warehouses.name as warehouse_name'
            , 'products.name as product_name'
            , 'product_adjustments.total as adjustments_amount'
            , 'product_adjustments.qty as adjustments_qty'
            , 'products.qty as stock_qty'
            , 'units.name as units_name'
            , 'units.value as units_value'
            , 'product_adjustments.action as action'
        );

        if($user_ware_house){
            $adjustments->whereIn('adjustments.warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $reportUrl .= '&product_ser='.$request->input('start_date');
            $adjustments->where('product_adjustments.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $reportUrl .= '&start_date='.$request->input('start_date');
            $adjustments->whereDate('adjustments.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $reportUrl .= '&end_date='.$request->input('end_date');
            $adjustments->whereDate('adjustments.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $adjustments->where('adjustments.warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('action_ser')){
            $reportUrl .= '&action_ser='.$request->input('action_ser');
            $adjustments->where('product_adjustments.action','=', $request->input('action_ser'));
        }
        $adjustments->orderBy('adjustments.created_at','DESC');

        $total_adjustment_qty = $adjustments->sum('product_adjustments.qty');
        $total_price          = $adjustments->sum('product_adjustments.total');

        $adjustments = $adjustments->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $fileName = 'adjustment-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Date', 'Reference', 'Warehouse', 'Action', 'Product Name'
        , 'Unit', 'Amount', 'Quantity');

        $callback = function() use($adjustments, $columns, $total_adjustment_qty, $total_price, $site_unit_val, $site_unit_name) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach($adjustments as $adjustment) {
                $action = ($adjustment->action == '+') ? 'Addition' : 'Subtraction';

                fputcsv($file, array(++$sl, date("d/m/Y", strtotime($adjustment->adjustments_date))
                , $adjustment->reference_no
                , $adjustment->warehouse_name
                , $action
                , $adjustment->product_name
                , $adjustment->units_name
                , number_format($adjustment->adjustments_amount, 2)
                , number_format($adjustment->adjustments_qty/$adjustment->units_value, 2)
                /*, $status*/
                ) );
            }
            fputcsv($file, array('','','','','','','Total',number_format($total_price, 2), number_format($total_adjustment_qty/$site_unit_val, 2).' '.$site_unit_name));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
