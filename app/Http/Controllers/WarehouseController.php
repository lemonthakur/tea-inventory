<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Cache;
use DB;

class WarehouseController extends Controller
{
    protected $moduleId = 21;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $warehouses = Warehouse::whereNotNull('id');
            if($request->input('q')){
                $q = $request->input('q');
                $warehouses->where(function($query) use($q){
                    $query->where('name', 'like', '%' . $q . '%');
                    $query->orWhere('email', 'like', '%' . $q . '%');
                    $query->orWhere('contact_no', 'like', '%' . $q . '%');
                });
            }
        $warehouses->orderBy('id','DESC');
        $warehouses = $warehouses->paginate(20);

        return view('backend.warehouse.index',compact('warehouses'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        return view('backend.warehouse.create');
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
            'name' => 'required|max:250',
            'email' => 'required|email|unique:warehouses',
            'contact_no' => 'max:128',
            'status' => 'integer|max:2',
            //'post_code' => 'mimes:csv,xls,xlsx',
        ];

        $message = [
            "name.required" => "Name is required",
            "contact_no.max" => "Mobile number can not exceed limit 25 characters.",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{
            DB::beginTransaction();

            try {
                $warehouse = new Warehouse();
                $warehouse->name         = $request->name;
                $warehouse->email        = $request->email;
                $warehouse->contact_no   = $request->contact_no;
                $warehouse->address      = $request->address;
                $warehouse->status       = $request->status;
                $warehouse->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/warehouse')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }
            DB::commit();

            session()->flash("success", 'Warehouse '.$warehouse->name.' created successfully.');
            return redirect()->route("warehouse.index");
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Model\Warehouse  $warehouse
     * @return \Illuminate\Http\Response
     */
    public function show(Warehouse $warehouse)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Model\Warehouse  $warehouse
     * @return \Illuminate\Http\Response
     */
    public function edit(Warehouse $warehouse)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        return view('backend.warehouse.edit',compact('warehouse'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Model\Role  $role
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Warehouse $warehouse)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            'name' => 'required|max:250',
            'email' => 'required|email|unique:warehouses,email,'.$warehouse->id,
            'contact_no' => 'max:128',
            'status' => 'integer|max:2',
            //'post_code' => 'mimes:csv,xls,xlsx',
        ];

        $message = [
            "name.required" => "Name is required",
            "contact_no.max" => "Mobile number can not exceed limit 25 characters.",
        ];
        $validation =  Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()->withInput()->withErrors($validation);
        }else{

            DB::beginTransaction();

            try {
                $warehouse->name         = $request->name;
                $warehouse->email        = $request->email;
                $warehouse->contact_no   = $request->contact_no;
                $warehouse->address      = $request->address;
                $warehouse->status       = $request->status;
                $warehouse->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/warehouse')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }

            DB::commit();

            session()->flash("success", 'Warehouse '.$warehouse->name.' updated successfully.');
            return redirect()->route("warehouse.index");

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Model\Warehouse  $role
     * @return \Illuminate\Http\Response
     */
    public function destroy(Warehouse $warehouse)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        if ($warehouse->Delete()){
            session()->flash("success","Warehouse Deleted");
            return redirect()->back();
        }else{
            session()->flash("error","Warehouse not Deleted");
            return redirect()->back();
        }
    }

}
