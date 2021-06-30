<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Product;
use App\Models\Product_Warehouse;
use App\Models\Production;
use App\Models\ProductionEmployee;
use App\Models\ProductionUseProduct;
use App\Models\Warehouse;
use App\Models\User;
use Illuminate\Http\Request;
use Cart;
use Illuminate\Support\Facades\Validator;

class ProductionController extends Controller
{
    protected $moduleId = 18;
    public function index(Request $request){
        OwnLibrary::validateAccess($this->moduleId, 1);

        $user_ware_house = OwnLibrary::user_warehosue();

        $productions = Production::with('product','warehouse')->orderBy('id','desc');

        if($user_ware_house){
            $productions->whereIn('warehouse_id', $user_ware_house)->orWhere('created_by',auth()->id());
        }
        if($request->input('warehouse_ser'))
            $productions->where('warehouse_id','=', $request->input('warehouse_ser'));
        if($request->input('employee_ser'))
            $productions->where('employee_id','=', $request->input('employee_ser'));

        if($request->input('product_ser'))
            $productions->where('product_id','=', $request->input('product_ser'));
        if($request->input('start_date'))
            $productions->whereDate('created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        if($request->input('end_date'))
            $productions->whereDate('created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));

        if($request->barcode){
            $value = explode('-', $request->barcode);
            $production_id = $value[0];
            $product_id = isset($value[1]) ? $value[1] : 0;
            $full_req = $request->barcode;

            $productions->where(function($query) use($production_id, $product_id, $full_req){
                $query->where('id', $production_id);
                $query->where('product_id', $product_id);
                $query->orWhere('production_number', $full_req);
            });

            //$productions->where('id', $production_id);
            //$productions->where('product_id', $product_id);
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


        return view('backend.production.index',compact('productions', 'warehouses', 'users'));
    }

    public function create(){
        OwnLibrary::validateAccess($this->moduleId, 2);
        $warehouses = Warehouse::orderBy('name');

        $user_ware_house = OwnLibrary::user_warehosue();
        if($user_ware_house){
            $warehouses->whereIn('id', $user_ware_house);
        }

        $warehouses = $warehouses->get();

        return view('backend.production.create',compact('warehouses'));
    }

    public function cartAdd(Request $request){
        $rules = [
            "nWarehouseId" => "required|integer",
            "nproductId" => "required|integer",
            "nQty" => "required",
        ];

        $message = [
            "nWarehouseId.required" => "This field is required",
            "nproductId.required" => "This field is required",
            "nQty.required" => "This field is required",
        ];

        $validation = Validator::make($request->all(), $rules, $message);
        if ($validation->fails()){
            return response()->json([
                'status' => 1,
                'errors' => $validation->getMessageBag(),
                'data' => ''
            ], 200);
        }

        $items = Cart::content();

        $checkCart = 0;

        foreach ($items as $item)
        {
            if($item->id == $request->nproductId && $item->options['warehouseId'] == $request->nWarehouseId)
            {
                $product = Product_Warehouse::where('product_id','=',$request->nproductId)
                    ->where('warehouse_id','=',$request->nWarehouseId)->first();

                $newQty = $item->qty + $request->nQty;
                if ($newQty > $product->qty){
                    return response()->json([
                        'status' => 2,
                        'data' => 'Warehouse does not have enough product.'
                    ], 200);
                }

                Cart::update($item->rowId, $item->qty+$request->nQty);
                $checkCart = 1;
            }
        }


        if ($checkCart == 0){
            $product = Product_Warehouse::with('product','product.unit','warehouse')
                ->where('product_id','=',$request->nproductId)
                ->where('warehouse_id','=',$request->nWarehouseId)->first();

            if ($request->nQty > $product->qty){
                return response()->json([
                    'status' => 2,
                    'data' => 'Warehouse does not have enough product.'
                ], 200);
            }


            Cart::add([
                'id' => $request->nproductId,
                'name' => $product->product->name,
                'qty' => $request->nQty,
                'price' => 0,
                'weight' => 0,
                'options' => [
                    'productCode' => $product->product->code,
                    'warehouseId' => $request->nWarehouseId,
                    'warehouseName' => $product->warehouse->name,
                    'unitId' => $product->product->unit->id,
                    'unit' => $product->product->unit->name,
                ],
                'taxRate' => 0,
            ]);
        }

        return response()->json([
            'status' => 3,
            'data' => Cart::content()
        ], 200);
    }

    public function removeCart(Request $request){
        Cart::remove($request->rowId);
        return response()->json([
            'status' => 3,
            'data' => Cart::content()
        ], 200);
    }

    public function store(Request $request){
        OwnLibrary::validateAccess($this->moduleId, 2);
        $rules = [
            "product" => "required",
            "targate_amount" => "required",
            "note" => "max:220",
        ];

        $message = [
            "product.required" => "This field is required",
            "targate_amount.required" => "This field is required",
            "barcode_symbology.required" => "This field is required",
        ];

        $validation = Validator::make($request->all(), $rules, $message);

        if ($validation->fails()) {
            return redirect()->back()->withInput()->withErrors($validation);
        }

        if (count(Cart::content()) == 0){
            session()->flash('error','Select Necessary Product');
            return redirect()->back()->withInput();
        }

        $produceProduct = Product::with('unit')->where('id','=',$request->product)->first();

        $production = new Production();
        $production->production_number ='pr-' . date("Ymd") . '-'. date("his");
        $production->product_id = $request->product;
        $production->employee_id = auth()->id();
        $production->unit_name = $produceProduct->unit->name;
        $production->unit_id = $produceProduct->unit->id;
        $production->note = $request->note;
        $production->targate_amount = $request->targate_amount;
        $production->ref_no = $request->ref_no ?? '';
        $production->barcode_symbology = $request->barcode_symbology;

        if ($production->save()){
            $productionId = $production->id;
            foreach(Cart::content() as $row){
//                reduce quantity from product
                $product = Product::find($row->id);
                $product->qty = $product->qty - $row->qty;
                $product->save();

//                reduce quantity from product warehouse
                $productWarehouse = Product_Warehouse::where('product_id','=',$row->id)
                    ->where('warehouse_id','=',$row->options['warehouseId'])->first();
                $productWarehouse->qty = $productWarehouse->qty - $row->qty;
                $productWarehouse->save();

//                Store in production_use_products
                $productionUseProduct = new ProductionUseProduct();
                $productionUseProduct->production_id = $productionId;
                $productionUseProduct->warehouse_id = $row->options['warehouseId'];
                $productionUseProduct->product_id = $row->id;
                $productionUseProduct->qty = $row->qty;
                $productionUseProduct->unit_name = $row->options['unit'];
                $productionUseProduct->unit_id = $row->options['unitId'];
                $productionUseProduct->save();
            }
            Cart::destroy();
            session()->flash('success','Production created');
            return redirect()->route('production.index');
        }
    }

    public function show($id){
        OwnLibrary::validateAccess($this->moduleId, 8);
        $production = Production::with('productionUse','productionUse.product','productionUse.warehouse',
            'product','warehouse','employee','employees')
            ->find($id);
        return view('backend.production.show',compact('production'));
    }

    public function edit($id){
        OwnLibrary::validateAccess($this->moduleId, 3);
        $warehouses = Warehouse::orderBy('name')->get();
        $production = Production::with('productionUse','productionUse.product','productionUse.warehouse','product','warehouse','employee')
            ->find($id);
        return view('backend.production.edit',compact('production','warehouses'));
    }

    public function update(Request $request,$id){
        OwnLibrary::validateAccess($this->moduleId, 3);

//        dd(count($request->employee_name));

        if (count($request->employee_name) <= 0 || !$request->employee_name[0]){
            session()->flash('error','Provide Employee Produce data');
            return redirect()->back()->withInput();
        }

        $rules = [
            "warehouse" => "required",
        ];

        $message = [];

        $validation = Validator::make($request->all(), $rules, $message);

        if ($validation->fails()) {
            return redirect()->back()->withInput()->withErrors($validation);
        }

      $production = Production::find($id);
        $production->warehouse_id = $request->warehouse;
        $production->status = 1;
//        $production->produce_amount = $request->produce_amount;
//        $production->waste_amount = $request->waste_amount;

        $toralProduce = 0;
        $toralWaste = 0;

        for ($i = 0; $i < count($request->employee_name); $i++){
            $productionEmployee = new ProductionEmployee();
            $productionEmployee->production_id = $id;
            $productionEmployee->employee_name = $request->employee_name[$i];
            $productionEmployee->produce_amount = $request->produce_amount[$i];
            $productionEmployee->waste_amount = $request->waste_amount[$i];
            $productionEmployee->save();

            $toralProduce = $toralProduce + $request->produce_amount[$i];
            $toralWaste = $toralWaste + $request->waste_amount[$i];
        }

        $production->produce_amount = $toralProduce;
        $production->waste_amount = $toralWaste;

        if ($production->save()){
            $product = Product::find($production->product_id);
            $product->qty = $product->qty + $toralProduce;
            $product->waste_qty = $product->waste_qty + $toralWaste;
            $product->save();

            $productWarehouse = Product_Warehouse::where('product_id','=',$production->product_id)
                ->where('warehouse_id','=',$request->warehouse)->first();

            if ($productWarehouse){
                $productWarehouse->qty = $productWarehouse->qty + $toralProduce;
                $productWarehouse->waste_qty = $productWarehouse->waste_qty + $toralWaste;
                $productWarehouse->save();
            }else{
                $productWarehouse = new Product_Warehouse();
                $productWarehouse->product_id = $production->product_id;
                $productWarehouse->warehouse_id = $request->warehouse;
                $productWarehouse->qty = $toralProduce;
                $productWarehouse->waste_qty = $toralWaste;
                $productWarehouse->save();
            }

            session()->flash('success','Production Finished');
            return redirect()->route('production.index');
        }else{
            session()->flash('error','Production Not Finished');
            return redirect()->route('production.index');
        }

    }
}
