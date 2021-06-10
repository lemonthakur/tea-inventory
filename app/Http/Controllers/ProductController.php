<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Keygen;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Unit;
use App\Models\Warehouse;
use App\Models\Supplier;
use App\Models\Product;
use Auth;
use DNS1D;
use DB;

class ProductController extends Controller
{
    protected $moduleId = 1;
    public function index()
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        //if($user_ware_house)

        $products = Product::whereNotNull('id');
        if($user_ware_house){

        }
        $products->orderBy('id','DESC');
        $products = $products->paginate(20);

        return view('backend.product.index', compact('products'));

    }

    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);

        $lims_brand_list = Brand::where('status', 1)->get();
        $lims_category_list = Category::where('status', 1)->get();
        $lims_unit_list = Unit::where('status', 1)->get();

        return view('backend.product.create',compact('lims_brand_list', 'lims_category_list', 'lims_unit_list'));
    }

    public function store(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $rules = [
            'name' => 'required|max:191|unique:products',
            'code' => 'required|max:191|unique:products',
            'barcode_symbology' => 'required|max:191',
            'brand_id' => 'required|integer',
            'category_id' => 'required|integer',
            'unit_id' => 'required|integer',
            'alert_quantity' => 'required',
            'status' => 'required|integer|max:2',
        ];

        $message = [
            "name.required" => "Product name is required.",
            "name.max" => "Please input maximum :max characters for Product name.",
            "code.required" => "Product code is required.",
            "code.max" => "Please input maximum :max characters for Product code.",
            "barcode_symbology.required" => "Barcode symbology is required.",
            "barcode_symbology.max" => "Please input maximum :max characters for Barcode symbology.",
            "brand_id.required" => "Brand is required.",
            "brand_id.integer" => "Brand should be integer value.",
            "category_id.required" => "Category is required.",
            "category_id.integer" => "Category should be integer value.",
            "unit_id.required" => "Unit is required.",
            "unit_id.integer" => "Unit should be integer value.",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        $images = $request->image;
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            DB::beginTransaction();

            try {
                $product = new Product();
                $product->name               = $request->name;
                $product->code               = $request->code;
                $product->barcode_symbology  = $request->barcode_symbology;
                $product->brand_id           = $request->brand_id;
                $product->category_id        = $request->category_id;
                $product->unit_id            = $request->unit_id;
                $product->product_price      = $request->product_price;
                $product->alert_quantity     = $request->alert_quantity;
                $product->status             = $request->status;
                $product->product_details    = $request->product_details;

                if ($request->hasFile('file')){
                    $product_file = OwnLibrary::uploadImage($request->file, "product/files");
                    $product->file = $product_file;
                }

                $images = $request->image;
                $image_names = [];
                if($images) {
                    foreach ($images as $key => $image) {
                        $imageName = $image->getClientOriginalName();
                        $image->move('public/upload/product/images', $imageName);
                        $image_names[] = 'public/upload/product/images/'.$imageName;
                    }
                    $product->image = json_encode($image_names);
                }
                else {
                    $product->image = json_encode(array('public/upload/product/images/zummXD2dvAtI.png'));
                }
                $product->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/product')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }
            DB::commit();

            session()->flash("success", 'Brand '.$product->name.' created successfully.');
            return redirect()->route("product.index");
        }
    }

    public function productData(Request $request)
    {
        $columns = array( 
            2 => 'name', 
            3 => 'code',
            4 => 'brand_id',
            5 => 'category_id',
            6 => 'qty',
            7 => 'unit_id',
            8 => 'price' 
        );
        
        $totalData = Product::where('is_active', true)->count();
        $totalFiltered = $totalData; 

        $limit = $request->input('length');
        $start = $request->input('start');
        $order = $columns[$request->input('order.0.column')];
        $dir = $request->input('order.0.dir');
        if(empty($request->input('search.value'))){
            $products = Product::with('category', 'brand', 'unit')->offset($start)
                        ->where('is_active', true)
                        ->limit($limit)
                        ->orderBy($order,$dir)
                        ->get();
        }
        else
        {
            $search = $request->input('search.value'); 
            $products =  Product::with('category', 'brand', 'unit')->where([
                            ['name', 'LIKE', "%{$search}%"],
                            ['is_active', true]
                        ])->orWhere([
                            ['code', 'LIKE', "%{$search}%"],
                            ['is_active', true]
                        ])
                        ->offset($start)
                        ->limit($limit)
                        ->orderBy($order,$dir)->get();

            $totalFiltered = Product::where([
                            ['name','LIKE',"%{$search}%"],
                            ['is_active', true]
                        ])->orWhere([
                            ['code', 'LIKE', "%{$search}%"],
                            ['is_active', true]
                        ])->count();
        }
        $data = array();
        if(!empty($products))
        {
            foreach ($products as $key=>$product)
            {
                $nestedData['id'] = $product->id;
                $nestedData['key'] = $key;
                $product_image = explode(",", $product->image);
                $nestedData['image'] = '<img src="'.url('public/images/product', $product_image[0]).'" height="80" width="80">';
                $nestedData['name'] = $product->name;
                $nestedData['code'] = $product->code;
                if($product->brand_id)
                    $nestedData['brand'] = $product->brand->title;
                else
                    $nestedData['brand'] = "N/A";
                $nestedData['category'] = $product->category->name;
                $nestedData['qty'] = $product->qty;
                if($product->unit_id)
                    $nestedData['unit'] = $product->unit->unit_name;
                else
                    $nestedData['unit'] = 'N/A';
                
                $nestedData['price'] = $product->price;
                $nestedData['options'] = '<div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'.trans("file.action").'
                              <span class="caret"></span>
                              <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                            <li>
                                <button="type" class="btn btn-link view"><i class="fa fa-eye"></i> '.trans('file.View').'</button>
                            </li>';
                if(in_array("products-edit", $request['all_permission']))
                    $nestedData['options'] .= '<li>
                            <a href="'.route('products.edit', ['id' => $product->id]).'" class="btn btn-link"><i class="fa fa-edit"></i> '.trans('file.edit').'</a>
                        </li>';
                if(in_array("products-delete", $request['all_permission']))
                    $nestedData['options'] .= \Form::open(["route" => ["products.destroy", $product->id], "method" => "DELETE"] ).'
                            <li>
                              <button type="submit" class="btn btn-link" onclick="return confirmDelete()"><i class="fa fa-trash"></i> '.trans("file.delete").'</button> 
                            </li>'.\Form::close().'
                        </ul>
                    </div>';
                // data for product details by one click
                if($product->tax_id)
                    $tax = Tax::find($product->tax_id)->name;
                else
                    $tax = "N/A";

                if($product->tax_method == 1)
                    $tax_method = trans('file.Exclusive');
                else
                    $tax_method = trans('file.Inclusive');

                $nestedData['product'] = array( '[ "'.$product->type.'"', ' "'.$product->name.'"', ' "'.$product->code.'"', ' "'.$nestedData['brand'].'"', ' "'.$nestedData['category'].'"', ' "'.$nestedData['unit'].'"', ' "'.$product->cost.'"', ' "'.$product->price.'"', ' "'.$tax.'"', ' "'.$tax_method.'"', ' "'.$product->alert_quantity.'"', ' "'.$product->product_details.'"', ' "'.$product->id.'"', ' "'.$product->product_list.'"', ' "'.$product->qty_list.'"', ' "'.$product->price_list.'"', ' "'.$product->qty.'"', ' "'.$product->image.'"]'
                );
                $nestedData['imagedata'] = DNS1D::getBarcodePNG($product->code, $product->barcode_symbology);
                $data[] = $nestedData;
            }
        }
        $json_data = array(
            "draw"            => intval($request->input('draw')),  
            "recordsTotal"    => intval($totalData),  
            "recordsFiltered" => intval($totalFiltered), 
            "data"            => $data   
        );
            
        echo json_encode($json_data);
    }

    public function edit(Product $product)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $lims_brand_list = Brand::where('status', 1)->get();
        $lims_category_list = Category::where('status', 1)->get();
        $lims_unit_list = Unit::where('status', 1)->get();

        return view('backend.product.edit',compact('lims_brand_list', 'lims_category_list', 'lims_unit_list', 'product'));
    }

    public function update(Request $request, Product $product)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            'name' => 'required|max:191|unique:products,name,'.$product->id,
            'code' => 'required|max:191|unique:products,code,'.$product->id,
            'barcode_symbology' => 'required|max:191',
            'brand_id' => 'required|integer',
            'category_id' => 'required|integer',
            'unit_id' => 'required|integer',
            'alert_quantity' => 'required',
            'status' => 'required|integer|max:2',
        ];

        $message = [
            "name.required" => "Product name is required.",
            "name.max" => "Please input maximum :max characters for Product name.",
            "code.required" => "Product code is required.",
            "code.max" => "Please input maximum :max characters for Product code.",
            "barcode_symbology.required" => "Barcode symbology is required.",
            "barcode_symbology.max" => "Please input maximum :max characters for Barcode symbology.",
            "brand_id.required" => "Brand is required.",
            "brand_id.integer" => "Brand should be integer value.",
            "category_id.required" => "Category is required.",
            "category_id.integer" => "Category should be integer value.",
            "unit_id.required" => "Unit is required.",
            "unit_id.integer" => "Unit should be integer value.",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        $images = $request->image;
        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            DB::beginTransaction();

            try {
                $product->name               = $request->name;
                $product->code               = $request->code;
                $product->barcode_symbology  = $request->barcode_symbology;
                $product->brand_id           = $request->brand_id;
                $product->category_id        = $request->category_id;
                $product->unit_id            = $request->unit_id;
                $product->product_price      = $request->product_price;
                $product->alert_quantity     = $request->alert_quantity;
                $product->status             = $request->status;
                $product->product_details    = $request->product_details;

                if ($request->hasFile('file')){
                    if($product->file) @unlink($product->file);

                    $product_file = OwnLibrary::uploadImage($request->file, "product/files");
                    $product->file = $product_file;
                }

                $images = $request->image;
                $image_names = [];
                if($images) {
                    // Delete existing image
                    if($product->image){
                        $imagesx = json_decode($product->image);
                        if($imagesx and count($imagesx)>0){
                            foreach($imagesx as $img){
                                if($img) @unlink($img);
                            }
                        }
                    }
                    // End existing image delet
                    foreach ($images as $key => $image) {
                        $imageName = $image->getClientOriginalName();
                        $image->move('public/upload/product/images', $imageName);
                        $image_names[] = 'public/upload/product/images/'.$imageName;
                    }
                    $product->image = json_encode($image_names);
                }
                else {
                    if(!$product->image)
                        $product->image = json_encode(array('public/upload/product/images/zummXD2dvAtI.png'));
                }
                $product->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/product')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }
            DB::commit();

            session()->flash("success", 'Product '.$product->name.' updated successfully.');
            return redirect()->route("product.index");
        }
    }

    public function peodutFileDownload($id){
        $id = $id;
        if($id){
            $product = Product::find($id);
            if($product->file){
                $headers = ['Content-Type: application/pdf'];

                $a = str_replace('public/', '', $product->file);
                $file= public_path().'/'. $a;

                $my_url = $product->file;
                $fileName = substr($my_url, strrpos($my_url, '/' )+1);
                return response()->download($file, $fileName, $headers);
            }
        }else{
            echo "<h2>Not found</h2>";
        }
    }

    public function generateCode()
    {
        $id = Keygen::numeric(10)->generate();
        return $id;
    }

    public function search(Request $request)
    {
        $product_code = explode(" ", $request['data']);
        $lims_product_data = Product::where('code', $product_code[0])->first();

        $product[] = $lims_product_data->name;
        $product[] = $lims_product_data->code;
        $product[] = $lims_product_data->qty;
        $product[] = $lims_product_data->price;
        $product[] = $lims_product_data->id;
        return $product;
    }

    public function saleUnit($id)
    {
        $unit = Unit::where("base_unit", $id)->orWhere('id', $id)->pluck('unit_name','id');
        return json_encode($unit);
    }

    public function getData($id)
    {
        $data = Product::select('name', 'code')->where('id', $id)->get();
        return $data[0];
    }

    public function productWarehouseData($id)
    {
        $warehouse = [];
        $qty = [];
        $warehouse_name = [];
        $variant_name = [];
        $variant_qty = [];
        $product_warehouse = [];
        $product_variant_warehouse = [];
        $lims_product_data = Product::select('is_variant')->find($id);
        if($lims_product_data->is_variant) {
            $lims_product_variant_warehouse_data = Product_Warehouse::where('product_id', 48)->orderBy('warehouse_id')->get();
            $lims_product_warehouse_data = Product_Warehouse::select('warehouse_id', DB::raw('sum(qty) as qty'))->where('product_id', $id)->groupBy('warehouse_id')->get();
            foreach ($lims_product_variant_warehouse_data as $key => $product_variant_warehouse_data) {
                $lims_warehouse_data = Warehouse::find($product_variant_warehouse_data->warehouse_id);
                $lims_variant_data = Variant::find($product_variant_warehouse_data->variant_id);
                $warehouse_name[] = $lims_warehouse_data->name;
                $variant_name[] = $lims_variant_data->name;
                $variant_qty[] = $product_variant_warehouse_data->qty;
                
            }
        }
        else{
            $lims_product_warehouse_data = Product_Warehouse::where('product_id', $id)->get();
        }
        foreach ($lims_product_warehouse_data as $key => $product_warehouse_data) {
            $lims_warehouse_data = Warehouse::find($product_warehouse_data->warehouse_id);
            $warehouse[] = $lims_warehouse_data->name;
            $qty[] = $product_warehouse_data->qty;
        }

        $product_warehouse = [$warehouse, $qty];
        $product_variant_warehouse = [$warehouse_name, $variant_name, $variant_qty];
        return ['product_warehouse' => $product_warehouse, 'product_variant_warehouse' => $product_variant_warehouse];
    }

    public function printBarcode()
    {
        $lims_product_list = Product::where('is_active', true)->get();
        return view('product.print_barcode', compact('lims_product_list'));
    }

    public function limsProductSearch(Request $request)
    {
        $todayDate = date('Y-m-d');
        $product_code = explode(" ", $request['data']);
        $lims_product_data = Product::where('code', $product_code[0])->first();
        $product[] = $lims_product_data->name;
        $product[] = $lims_product_data->code;
        $product[] = $lims_product_data->price;
        $product[] = DNS1D::getBarcodePNG($lims_product_data->code, $lims_product_data->barcode_symbology);
        $product[] = $lims_product_data->promotion_price;
        return $product;
    }

    public function importProduct(Request $request)
    {   
        //get file
        $upload=$request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if($ext != 'csv')
            return redirect()->back()->with('message', 'Please upload a CSV file');

        $filePath=$upload->getRealPath();
        //open and read
        $file=fopen($filePath, 'r');
        $header= fgetcsv($file);
        $escapedHeader=[];
        //validate
        foreach ($header as $key => $value) {
            $lheader=strtolower($value);
            $escapedItem=preg_replace('/[^a-z]/', '', $lheader);
            array_push($escapedHeader, $escapedItem);
        }
        //looping through other columns
        while($columns=fgetcsv($file))
        {
            if($columns[0]=="")
                continue;
            foreach ($columns as $key => $value) {
                $value=preg_replace('/\D/','',$value);
            }
           $data= array_combine($escapedHeader, $columns);
           
           if($data['brand'] != 'N/A' && $data['brand'] != ''){
                $lims_brand_data = Brand::firstOrCreate(['title' => $data['brand'], 'is_active' => true]);
                $brand_id = $lims_brand_data->id;
           }
            else
                $brand_id = null;

           $lims_category_data = Category::firstOrCreate(['name' => $data['category'], 'is_active' => true]);

           $lims_unit_data = Unit::where('unit_code', $data['unitcode'])->first();

           $product = Product::firstOrNew([ 'name'=>$data['name'], 'is_active'=>true ]);
           $product->image = $data['image'];
           $product->name = $data['name'];
           $product->code = $data['code'];
           $product->type = strtolower($data['type']);
           $product->barcode_symbology = 'C128';
           $product->brand_id = $brand_id;
           $product->category_id = $lims_category_data->id;
           $product->unit_id = $lims_unit_data->id;
           $product->purchase_unit_id = $lims_unit_data->id;
           $product->sale_unit_id = $lims_unit_data->id;
           $product->cost = $data['cost'];
           $product->price = $data['price'];
           $product->tax_method = 1;
           $product->qty = 0;
           $product->product_details = $data['productdetails'];
           $product->is_active = true;
           $product->save();
         }
         return redirect('products')->with('import_message', 'Product imported successfully');
    }

    public function deleteBySelection(Request $request)
    {
        $product_id = $request['productIdArray'];
        foreach ($product_id as $id) {
            $lims_product_data = Product::findOrFail($id);
            $lims_product_data->is_active = false;
            $lims_product_data->save();
        }
        return 'Product deleted successfully!';
    }

    public function destroy(Product $product)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        if ($product->Delete()){
            if($product->file) @unlink($product->file);
            // Delete existing image
            if($product->image){
                $imagesx = json_decode($product->image);
                if($imagesx and count($imagesx)>0){
                    foreach($imagesx as $img){
                        if($img) @unlink($img);
                    }
                }
            }
            // End existing image delet

            session()->flash("success","Product Deleted");
            return redirect()->back();
        }else{
            session()->flash("error","Product not Deleted");
            return redirect()->back();
        }
    }
}
