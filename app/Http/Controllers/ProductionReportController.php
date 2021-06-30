<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Product_Warehouse;
use App\Models\Production;
use App\Models\SiteSetting;
use App\Models\Warehouse;
use App\Models\User;
use Illuminate\Http\Request;

class ProductionReportController extends Controller
{
    public function index(Request $request){

        $user_ware_house = OwnLibrary::user_warehosue();

        $productions = Production::select(
            'productions.id as production_id',
            'productions.production_number as production_number',
            'productions.produce_amount as produce_amount',
            'productions.waste_amount as waste_amount',
            'productions.unit_name as unit_name',
            'productions.created_at as start_at',
            'productions.updated_at as end_at',
            'productions.product_id as product_id',
            'productions.warehouse_id as warehouse_id',
            'productions.status as status',
            'products.name as product_name',
            'users.name as employee_name',
            'warehouses.name as warehouse_name',
        )
            ->join("products", "productions.product_id","=","products.id")
            ->join("users", "productions.employee_id","=","users.id")
            ->leftJoin("warehouses", "productions.warehouse_id","=","warehouses.id");

        if($user_ware_house){
            $productions->whereIn('warehouse_id', $user_ware_house);
        }

        if ($request->product_ser){
            $productions->where('product_id', $request->product_ser);
        }

        if ($request->warehouse_ser){
            $productions->where('warehouse_id', $request->warehouse_ser);
        }

        if ($request->production_start_from){
            $productions->whereDate('productions.created_at','>=',date("Y-m-d", strtotime($request->production_start_from)));
        }

        if ($request->production_start_to){
            $productions->whereDate('productions.created_at','<=',date("Y-m-d", strtotime($request->production_start_to)));
        }


        if ($request->production_finished_from){
            $productions->whereDate('productions.updated_at','>=',date("Y-m-d", strtotime($request->production_finished_from)));
        }

        if ($request->production_finished_to){
            $productions->whereDate('productions.updated_at','<=',date("Y-m-d", strtotime($request->production_finished_to)));
        }

        if ($request->production_finished_from || $request->production_finished_to){
            $productions->where('productions.status','=',1);
        }

        if ($request->status){
            $productions->where('productions.status','=',$request->status - 1);
        }
        if($request->input('employee_ser'))
            $productions->where('productions.employee_id','=', $request->input('employee_ser'));
        if($request->barcode){
            $value = explode('-', $request->barcode);
            $production_id = $value[0];
            $product_id = isset($value[1]) ? $value[1] : 0;
            $full_req = $request->barcode;

            $productions->where(function($query) use($production_id, $product_id, $full_req){
                $query->where('productions.id', $production_id);
                $query->where('productions.product_id', $product_id);
                $query->orWhere('productions.production_number', $full_req);
            });

            //$productions->where('productions.id', $production_id);
            //$productions->where('productions.product_id', $product_id);
        }

        $productions = $productions->paginate(20);

        $warehouses = Warehouse::select('id','name')->orderBy('name');
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }
        $warehouses = $warehouses->get();

        if($user_ware_house){
            $users = User::join('employee_warhouses', 'employee_warhouses.user_id', '=', 'users.id')
                ->where('users.status', 1)
                ->whereIn('employee_warhouses.warehouse_id', $user_ware_house)
                ->select('users.*')
                ->groupBy('users.id')
                ->get();
        }else{
            $users = User::where('status', 1)->get();
        }

        return view('backend.production-report.index',compact('productions','warehouses', 'users'));
    }

    public function excel(Request $request){
        $user_ware_house = OwnLibrary::user_warehosue();

        $productions = Production::select(
            'productions.id as production_id',
            'productions.production_number as production_number',
            'productions.produce_amount as produce_amount',
            'productions.waste_amount as waste_amount',
            'productions.unit_name as unit_name',
            'productions.created_at as start_at',
            'productions.updated_at as end_at',
            'productions.product_id as product_id',
            'productions.warehouse_id as warehouse_id',
            'productions.status as status',
            'products.name as product_name',
            'users.name as employee_name',
            'warehouses.name as warehouse_name',
        )
            ->join("products", "productions.product_id","=","products.id")
            ->join("users", "productions.employee_id","=","users.id")
            ->leftJoin("warehouses", "productions.warehouse_id","=","warehouses.id");

        if($user_ware_house){
            $productions->whereIn('warehouse_id', $user_ware_house);
        }

        if ($request->product_ser){
            $productions->where('product_id', $request->product_ser);
        }

        if ($request->warehouse_ser){
            $productions->where('warehouse_id', $request->warehouse_ser);
        }

        if ($request->production_start_from){
            $productions->where('productions.created_at','>=',date("Y-m-d", strtotime($request->production_start_from)));
        }

        if ($request->production_start_to){
            $productions->where('productions.created_at','<=',date("Y-m-d", strtotime($request->production_start_to)));
        }

        if ($request->production_finished_from){
            $productions->where('productions.updated_at','>=',date("Y-m-d", strtotime($request->production_finished_from)));
        }

        if ($request->production_start_to){
            $productions->where('productions.updated_at','<=',date("Y-m-d", strtotime($request->production_finished_to)));
        }

        if ($request->status){
            $productions->where('productions.status','=',$request->status - 1);
        }
        if($request->input('employee_ser'))
            $productions->where('productions.employee_id','=', $request->input('employee_ser'));

        $productions = $productions->get();

        $fileName = 'Production-'.date('d/m/Y H:i a').'.csv';

        $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=$fileName",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $columns = array('SL','Production Number', 'Warehouse', 'Product Name', 'Produce','Waste','Unit','Employee','Start At','End At','status');

        $callback = function() use($productions, $columns) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            $sl = 1;

            foreach ($productions as $production) {
                $row['SL']  = $sl++;
                $row['Production Number']  = ucwords($production->production_number);
                $row['Warehouse']    = $production->warehouse_name;
                $row['Product Name']    = $production->product_name;
                $row['Produce']  = number_format($production->produce_amount,2);
                $row['Waste']  = number_format($production->waste_amount,2);
                $row['Unit']  = $production->unit_name;
                $row['Employee']  = ucwords($production->employee_name);
                $row['Start At']  = date('d-m-Y',strtotime($production->start_at));

                if($production->status == 1) {
                    $row['End At'] = date('d-m-Y',strtotime($production->end_at));
                }else{
                    $row['End At'] = '';
                }
                if ($production->status == 1){
                    $row['Status']  = 'Finished';
                }else{
                    $row['Status']  = 'On Going';
                }

                fputcsv($file, array($row['SL'],$row['Production Number'], $row['Warehouse'], $row['Product Name'],
                    $row['Produce'],$row['Waste'],$row['Unit'],$row['Employee'],$row['Start At'],$row['End At'],$row['Status']));
            }

            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }
}
