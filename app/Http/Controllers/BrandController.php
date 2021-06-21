<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Cache;
use DB;

class BrandController extends Controller
{
    protected $moduleId = 19;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $brands = Brand::whereNotNull('id');
        if($request->input('q')){
            $q = $request->input('q');
            $brands->where(function($query) use($q){
                $query->where('name', 'like', '%' . $q . '%');
                $query->orWhere('brand_mobile', 'like', '%' . $q . '%');
                $query->orWhere('brand_email', 'like', '%' . $q . '%');
            });
        }
        $brands->orderBy('id','DESC');
        $brands = $brands->paginate(20);

        return view('backend.brand.index',compact('brands'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        return view('backend.brand.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $rules = [
            'name' => 'required|max:500',
            'brand_email' => 'email',
            'status' => 'integer|max:2',
        ];

        $message = [
            "name.required" => "Brand name is required",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            DB::beginTransaction();

            try {
                $brand = new Brand();
                $brand->name         = $request->name;
                $brand->brand_representatives_name  = $request->brand_representatives_name;
                $brand->brand_email  = $request->brand_email;
                $brand->brand_mobile  = $request->brand_mobile;
                $brand->address  = $request->address;
                $brand->description  = $request->description;
                $brand->status       = $request->status;

                if ($request->hasFile('brand_thumbnail')){
                    $brand_thumbnail = OwnLibrary::uploadImage($request->brand_thumbnail, "brand");
                    $brand->brand_thumbnail = $brand_thumbnail;
                }

                if ($request->hasFile('brand_banner')){
                    $brand_banner = OwnLibrary::uploadImage($request->brand_banner, "brand");
                    $brand->brand_banner = $brand_banner;
                }

                $brand->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/brand')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }
            DB::commit();

            session()->flash("success", 'Brand '.$brand->name.' created successfully.');
            return redirect()->route("brand.index");
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function show(Brand $brand)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function edit(Brand $brand)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        return view('backend.brand.edit',compact('brand'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Brand $brand)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            'name' => 'required|max:500',
            'brand_email' => 'email',
            'status' => 'integer|max:2',
        ];

        $message = [
            "name.required" => "Name is required",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{

            DB::beginTransaction();

            try {
                $brand->name         = $request->name;
                $brand->brand_representatives_name  = $request->brand_representatives_name;
                $brand->brand_email  = $request->brand_email;
                $brand->brand_mobile  = $request->brand_mobile;
                $brand->address  = $request->address;
                $brand->description  = $request->description;
                $brand->status       = $request->status;

                if ($request->hasFile('brand_thumbnail')){
                    if (!empty($brand->brand_thumbnail)){
                        @unlink($brand->brand_thumbnail);
                    }
                    $brand_thumbnail = OwnLibrary::uploadImage($request->brand_thumbnail, "brand");
                    $brand->brand_thumbnail = $brand_thumbnail;
                }
                if ($request->hasFile('brand_banner')){
                    if (!empty($brand->brand_banner)){
                        @unlink($brand->brand_banner);
                    }
                    $brand_banner = OwnLibrary::uploadImage($request->brand_banner, "brand");
                    $brand->brand_banner = $brand_banner;
                }
                $brand->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/brand')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }

            DB::commit();

            session()->flash("success", 'Brand '.$brand->name.' updated successfully.');
            return redirect()->route("brand.index");

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Model\Warehouse  $role
     * @return \Illuminate\Http\Response
     */
    public function destroy(Brand $brand)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        if ($brand->Delete()){
            session()->flash("success","Brand Deleted");
            return redirect()->back();
        }else{
            session()->flash("error","Brand not Deleted");
            return redirect()->back();
        }
    }

}
