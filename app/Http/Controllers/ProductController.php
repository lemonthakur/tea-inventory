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
    protected $moduleId = 12;
    public function index()
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();

        $products = Product::whereNotNull('products.id');
        if($user_ware_house){
            $products->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id');
            //$products->select('products.*', 'product_warehouse.qty as qtys', DB::raw("SUM(product_warehouse.qty) as qtys"));
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
            );
            $products->whereIn('product_warehouse.warehouse_id', $user_ware_house);
            $products->groupBy('products.id');
        }
        $products->orderBy('products.id','DESC');

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
//            'alert_quantity' => 'required',
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
//                $product->alert_quantity     = $request->alert_quantity;
                $product->alert_quantity     = 0;
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
//            'alert_quantity' => 'required',
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
//                $product->alert_quantity     = $request->alert_quantity;
                $product->alert_quantity     = 0;
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

    public function product_warehouse_qty_get(Request $request){
        $product_id = $request->product_id;

        $user_ware_house = OwnLibrary::user_warehosue();

        $lims_product_data = Product::Find($product_id);
        $lims_product_warehouse_data = \App\Models\Product_Warehouse::where('product_id', $product_id);
        if($user_ware_house){
            $lims_product_warehouse_data->whereIn('warehouse_id', $user_ware_house);
        }
        $lims_product_warehouse_data = $lims_product_warehouse_data->get();

        $html = '';
        $html .= '<thead>';
            $html .= '<tr>';
                $html .= '<th>Warehouse</th>';
                $html .= '<th>Quantity</th>';
                /*$html .= '<th>Waste</th>';*/
            $html .= '</tr>';
        $html .= '</thead>';
        $html .= '<tbody>';
        foreach ($lims_product_warehouse_data as $key => $product_warehouse_data) {
            $lims_warehouse_data = Warehouse::find($product_warehouse_data->warehouse_id);

            $html .= '<tr>';
                $html .= '<td class="text-center">'.$lims_warehouse_data->name.'</td>';
                $html .= '<td class="text-right">'.$product_warehouse_data->qty/$lims_product_data->unit->value.'</td>';
                /*$html .= '<td class="text-right">'.$product_warehouse_data->waste_qty/$lims_product_data->unit->value.'</td>';*/
            $html .= '</tr>';
        }
        $html .= '</tbody>';

        return $html;
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
        /*$product_code = explode(" ", $request['data']);
        $lims_product_data = Product::where('code', $product_code[0])->first();

        $product[] = $lims_product_data->name;
        $product[] = $lims_product_data->code;
        $product[] = $lims_product_data->qty;
        $product[] = $lims_product_data->price;
        $product[] = $lims_product_data->id;
        return $product;*/

        $search = $request->search;
        $products = Product::select('id', DB::raw("CONCAT(code,' ','(',name,')') AS text"))
            ->where('name','LIKE',"$search%")
            ->orWhere('code','LIKE',"$search%")
            ->limit(10)->get();
        return response()->json($products);
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
        OwnLibrary::validateAccess(14,7);
        return view('backend.product.print_barcode');
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

    public function product_wise_row_get(Request $request){
        $product_id = $request->product_id;
        $product = Product::find($product_id);
        $unit = Unit::find($product->unit_id);

        $row = '';

        $row .= '<tr class="rows" id="">';
            $row .= '<td>'.$product->name.'</td>';
            $row .= '<td>'.$product->code.'</td>';
            $row .= '<td>'.$unit->name.'</td>';
            $row .= '<td>
                <input type="hidden" class="form-control product_id" name="product_id[]" value="'.$product->id.'" required="" autocomplete="off">
                <input type="number" class="form-control qty" name="qty[]" value="1" step="any" min="1" autocomplete="off">
                <input type="hidden" class="avaiableQty" name="avaiableQty[]" value="">
            </td>';
            $row .= '<td class="net_unit_cost text-center">'.$product->product_price.'
                <input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
            </td>';
            $row .= '<td class="sub-total text-center">'.$product->product_price.'</td>';
            $row .= '<input type="hidden" class="subtotal-input" name="subtotal_input[]" value="1">';
            $row .= '<td>
               <div>
                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                       <i class="far fa-trash-alt"></i>
                   </button>
               </div>
            </td>';
        $row .= '</tr>';

        return $row;
    }

    public function product_wise_row_short_get(Request $request){
        $product_id = $request->product_id;
        $product = Product::find($product_id);
        $barcode_image = OwnLibrary::barcode_generator($product->code, $product->barcode_symbology);

        $row = '';
        $row .= '<tr data-imagedata="'.$barcode_image.'" data-price="'.$product->product_price.'">';
            $row .= '<td>'.$product->name.'</td>';
            $row .= '<td class="product-code">'.$product->code.'</td>';
            $row .= '<td><input type="number" class="form-control qty" name="qty[]" value="1" /></td>';
            $row .= '<td>
               <div>
                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                       <i class="far fa-trash-alt"></i>
                   </button>
               </div>
            </td>';
        $row .= '</tr>';

        return $row;
    }
}
