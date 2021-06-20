<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Product_Warehouse;
use App\Models\Production;
use App\Models\ProductionUseProduct;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use Cart;
use Illuminate\Support\Facades\Validator;

class ProductionController extends Controller
{
    public function index(){
        $productions = Production::with('product','warehouse')->orderBy('id','desc')->paginate(20);
        return view('backend.production.index',compact('productions'));
    }

    public function create(){
        $warehouses = Warehouse::orderBy('name')->get();
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
            if($item->id == $request->nproductId)
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

        $rules = [
            "product" => "required",
            "note" => "max:220",
        ];

        $message = [
            "product.required" => "This field is required",
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
        $production = Production::with('productionUse','productionUse.product','productionUse.warehouse','product','warehouse','employee')
            ->find($id);
        return view('backend.production.show',compact('production'));
    }

    public function edit($id){
        $warehouses = Warehouse::orderBy('name')->get();
        $production = Production::with('productionUse','productionUse.product','productionUse.warehouse','product','warehouse','employee')
            ->find($id);
        return view('backend.production.edit',compact('production','warehouses'));
    }

    public function update(Request $request,$id){

        $rules = [
            "warehouse" => "required",
            "produce_amount" => "required",
            "waste_amount" => "required",
        ];

        $message = [];

        $validation = Validator::make($request->all(), $rules, $message);

        if ($validation->fails()) {
            return redirect()->back()->withInput()->withErrors($validation);
        }

      $production = Production::find($id);
        $production->warehouse_id = $request->warehouse;
        $production->produce_amount = $request->produce_amount;
        $production->waste_amount = $request->waste_amount;
        $production->status = 1;
        if ($production->save()){

            $product = Product::find($production->product_id);
            $product->qty = $product->qty + $request->produce_amount;
            $product->waste_qty = $product->waste_qty + $request->waste_amount;
            $product->save();

            $productWarehouse = Product_Warehouse::where('product_id','=',$production->product_id)
                ->where('warehouse_id','=',$request->warehouse)->first();

            if ($productWarehouse){
                $productWarehouse->qty = $productWarehouse->qty + $request->produce_amount;
                $productWarehouse->waste_qty = $productWarehouse->waste_qty + $request->waste_amount;
                $productWarehouse->save();
            }else{
                $productWarehouse = new Product_Warehouse();
                $productWarehouse->product_id = $production->product_id;
                $productWarehouse->warehouse_id = $request->warehouse;
                $productWarehouse->qty = $request->produce_amount;
                $productWarehouse->waste_qty = $request->waste_amount;
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