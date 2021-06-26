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

class TransferReportController extends Controller
{
    protected $moduleId = 15;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();

        $reportUrl = \App::make('url')->to('/').'/transfer-report-excel?';
        $transfers = Product::join("product_transfer", "product_transfer.product_id","=","products.id")
                    ->join("transfers", "transfers.id","=","product_transfer.transfer_id")
                    ->join("warehouses as from_warehouses", "from_warehouses.id","=","transfers.from_warehouse_id")
                    ->join("warehouses as to_warehouses", "to_warehouses.id","=","transfers.to_warehouse_id")
                    ->join("units", "units.id","=","product_transfer.purchase_unit_id");
        $transfers->select(
                        'transfers.created_at as transfer_date'
                        , 'transfers.reference_no'
                        , 'from_warehouses.name as from_warehouse_name'
                        , 'to_warehouses.name as to_warehouse_name'
                        , 'products.name as product_name'
                        , 'product_transfer.total as transfer_amount'
                        , 'product_transfer.qty as transfer_qty'
                        , 'products.qty as stock_qty'
                        , 'units.name as units_name'
                        , 'units.value as units_value'
                    );

        if($user_ware_house){
            $transfers->whereIn('transfers.from_warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $reportUrl .= '&product_ser='.$request->input('start_date');
            $transfers->where('product_transfer.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $reportUrl .= '&start_date='.$request->input('start_date');
            $transfers->whereDate('transfers.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $reportUrl .= '&end_date='.$request->input('end_date');
            $transfers->whereDate('transfers.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $reportUrl .= '&warehouse_ser='.$request->input('warehouse_ser');
            $transfers->where('transfers.from_warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('to_warehouse_ser')){
            $reportUrl .= '&to_warehouse_ser='.$request->input('to_warehouse_ser');
            $transfers->where('transfers.to_warehouse_id','=', $request->input('to_warehouse_ser'));
        }
        $transfers->orderBy('transfers.id','DESC');

        $total_transfer_qty = $transfers->sum('product_transfer.qty');
        $total_price        = $transfers->sum('product_transfer.total');

        $transfers = $transfers->paginate(50);

        $warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        $to_warehouses = Warehouse::select('id','name')->where('status', 1)->orderBy('name')->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';

        return view('backend.reports.transfer-report', compact('transfers', 'warehouses', 'reportUrl'
            , 'total_transfer_qty', 'total_price', 'site_setting', 'site_unit', 'to_warehouses'));
    }

    public function transferReportExcel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $user_ware_house = OwnLibrary::user_warehosue();

        $transfers = Product::join("product_transfer", "product_transfer.product_id","=","products.id")
            ->join("transfers", "transfers.id","=","product_transfer.transfer_id")
            ->join("warehouses as from_warehouses", "from_warehouses.id","=","transfers.from_warehouse_id")
            ->join("warehouses as to_warehouses", "to_warehouses.id","=","transfers.to_warehouse_id")
            ->join("units", "units.id","=","product_transfer.purchase_unit_id");
        $transfers->select(
            'transfers.created_at as transfer_date'
            , 'transfers.reference_no'
            , 'from_warehouses.name as from_warehouse_name'
            , 'to_warehouses.name as to_warehouse_name'
            , 'products.name as product_name'
            , 'product_transfer.total as transfer_amount'
            , 'product_transfer.qty as transfer_qty'
            , 'products.qty as stock_qty'
            , 'units.name as units_name'
            , 'units.value as units_value'
        );

        if($user_ware_house){
            $transfers->whereIn('transfers.from_warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $transfers->where('product_transfer.product_id', $request->input('product_ser'));
        }
        if($request->input('start_date')){
            $transfers->whereDate('transfers.created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        }
        if($request->input('end_date')){
            $transfers->whereDate('transfers.created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));
        }
        if($request->input('warehouse_ser')){
            $transfers->where('transfers.from_warehouse_id','=', $request->input('warehouse_ser'));
        }
        if($request->input('to_warehouse_ser')){
            $transfers->where('transfers.to_warehouse_id','=', $request->input('to_warehouse_ser'));
        }
        $transfers->orderBy('transfers.id','DESC');

        $total_transfer_qty = $transfers->sum('product_transfer.qty');
        $total_price        = $transfers->sum('product_transfer.total');

        $transfers = $transfers->get();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $fileName = 'transfer-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Date', 'Reference', 'From Warehouse', 'To Warehouse', 'Product Name'
        , 'Unit', 'Amount', 'Qty');

        $callback = function() use($transfers, $columns, $total_transfer_qty, $total_price, $site_unit_val, $site_unit_name) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach($transfers as $transfer) {
                fputcsv($file, array(++$sl, date("d/m/Y", strtotime($transfer->transfer_date))
                , $transfer->reference_no
                , $transfer->from_warehouse_name
                , $transfer->to_warehouse_name
                , $transfer->product_name
                , $transfer->units_name
                , number_format($transfer->transfer_amount, 2)
                , number_format($transfer->transfer_qty/$transfer->units_value, 2)
                /*, $status*/
                ) );
            }
            fputcsv($file, array('','','','','','','Total',number_format($total_price, 2), number_format($total_transfer_qty/$site_unit_val, 2).' '.$site_unit_name));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
