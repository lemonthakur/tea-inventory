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

class ProductHistoryController extends Controller
{
    protected $moduleId = 33;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        $reportUrl = \App::make('url')->to('/').'/product-history-excel?';

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $product_histories = null;
        if($request->input('product_ser')){
            // order
            $purchase = Product::join('product_purchases', 'product_purchases.product_id', '=', 'products.id')
                                ->join('units', 'units.id', '=', 'products.unit_id')
                                ->where('products.id', $request->input('product_ser'))
                                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                                , 'product_purchases.created_at AS date', 'product_purchases.qty AS purchase_qty'
                                , DB::raw('0 AS adjustment_qty'), DB::raw('0 AS production_qty'), DB::raw('0 as action'), DB::raw('0 AS production_use_qty'));

            $adjustments = Product::join('product_adjustments', 'product_adjustments.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                    , 'product_adjustments.created_at AS date', DB::raw('0 AS purchase_qty')
                    , 'product_adjustments.qty AS adjustment_qty', DB::raw('0 AS production_qty'), DB::raw('product_adjustments.action as action'), DB::raw('0 AS production_use_qty'));

            $productions = Product::join('productions', 'productions.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS units_value'
                    , 'productions.created_at AS date', DB::raw('0 AS purchase_qty'), DB::raw('0 AS unit_value')
                    , 'productions.produce_amount AS production_qty', DB::raw('0 as action'), DB::raw('0 AS production_use_qty'));

            $use_in_production = Product::join('production_use_products', 'production_use_products.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                    , 'production_use_products.created_at AS date', DB::raw('0 AS purchase_qty'), DB::raw('0 AS adjustment_qty')
                    , DB::raw('0 AS production_qty'), DB::raw('0 as action'), 'production_use_products.qty AS production_use_qty')
                    ->unionAll($purchase)
                    ->unionAll($adjustments)
                    ->unionAll($productions);

            $product_histories = \DB::query()->fromSub($use_in_production, 'products')
                ->select('*')
                ->orderBy('date', 'ASC')
                ->get();

            $reportUrl .= '&product_ser='.$request->input('product_ser');
        }

        return view('backend.product-history.index', compact('product_histories', 'site_setting'
            , 'site_unit', 'site_unit_val', 'reportUrl', 'site_unit_name'));
    }

    public function excel(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);
        $user_ware_house = OwnLibrary::user_warehosue();

        $site_setting = SiteSetting::find(1);
        $site_unit = ($site_setting->display_unit) ? Unit::find($site_setting->display_unit) : '';
        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
        $site_unit_name = ($site_unit) ? $site_unit->name : '';

        $product_histories = null;
        if($request->input('product_ser')){
            // order
            $purchase = Product::join('product_purchases', 'product_purchases.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                    , 'product_purchases.created_at AS date', 'product_purchases.qty AS purchase_qty'
                    , DB::raw('0 AS adjustment_qty'), DB::raw('0 AS production_qty'), DB::raw('0 as action'), DB::raw('0 AS production_use_qty'));

            $adjustments = Product::join('product_adjustments', 'product_adjustments.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                    , 'product_adjustments.created_at AS date', DB::raw('0 AS purchase_qty')
                    , 'product_adjustments.qty AS adjustment_qty', DB::raw('0 AS production_qty'), DB::raw('product_adjustments.action as action'), DB::raw('0 AS production_use_qty'));

            $productions = Product::join('productions', 'productions.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS units_value'
                    , 'productions.created_at AS date', DB::raw('0 AS purchase_qty'), DB::raw('0 AS unit_value')
                    , 'productions.produce_amount AS production_qty', DB::raw('0 as action'), DB::raw('0 AS production_use_qty'));

            $use_in_production = Product::join('production_use_products', 'production_use_products.product_id', '=', 'products.id')
                ->join('units', 'units.id', '=', 'products.unit_id')
                ->where('products.id', $request->input('product_ser'))
                ->select('products.name', 'products.code', 'products.qty AS total_qty', 'units.value AS unit_value'
                    , 'production_use_products.created_at AS date', DB::raw('0 AS purchase_qty'), DB::raw('0 AS adjustment_qty')
                    , DB::raw('0 AS production_qty'), DB::raw('0 as action'), 'production_use_products.qty AS production_use_qty')
                ->unionAll($purchase)
                ->unionAll($adjustments)
                ->unionAll($productions);

            $product_histories = \DB::query()->fromSub($use_in_production, 'products')
                ->select('*')
                ->orderBy('date', 'ASC')
                ->get();
        }

        $fileName = 'product-history-report.csv';
        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL', 'Date', 'Name', 'Code', 'Source', 'Quantity');

        $callback = function() use($product_histories, $columns, $site_setting, $site_unit, $site_unit_val, $site_unit_name) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            $in_stock = 0;
            $qty = 0;
            $action = '+';

            foreach($product_histories as $ph) {

                if($ph->purchase_qty){
                    $text = 'Order';
                    $in_stock += $ph->purchase_qty; $qty = $ph->purchase_qty; $action = '+';
                }elseif($ph->adjustment_qty){
                    $text = 'Adjustment (Addition)';
                    if($ph->action == '+'){
                        $text = 'Adjustment (Addition)';
                        $in_stock += $ph->adjustment_qty; $qty = $ph->adjustment_qty; $action = '+';
                    } else{
                        $text = 'Adjustment (Subtraction)';
                        $in_stock -= $ph->adjustment_qty; $qty = $ph->adjustment_qty; $action = '-';
                    }
                }elseif($ph->production_qty){
                    $text = 'Production';
                    $in_stock += $ph->production_qty; $qty = $ph->production_qty; $action = '+';
                }else{
                    $text = 'Use in production';
                    $in_stock -= $ph->production_use_qty; $qty = $ph->production_use_qty; $action = '-';
                }

                if($action == '+')
                    $qty = number_format($qty/$ph->unit_value, 2);
                else
                    $qty = '('. number_format($qty/$ph->unit_value, 2). ')';

                fputcsv($file, array($sl++
                , date("d/m/Y", strtotime($ph->date))
                , $ph->name
                , $ph->code
                , $text
                , $qty
                ) );
            }
            fputcsv($file, array('','','','','Total', number_format($in_stock/$site_unit_val, 2).' '.$site_unit_name ));
            fclose($file);
        };
        return response()->stream($callback, 200, $headers);
    }
}
