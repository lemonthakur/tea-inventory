<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Unit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Cache;
use DB;

class UnitController extends Controller
{
    protected $moduleId = 1;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $units = Unit::whereNotNull('id');
        $units->orderBy('id','DESC');
        $units = $units->paginate(20);

        return view('backend.unit.index',compact('units'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        return view('backend.unit.create');
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
            'value' => 'required',
            'description' => 'max:500',
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
                $unit = new Unit();
                $unit->name         = $request->name;
                $unit->value         = $request->value;
                $unit->description  = $request->description;
                $unit->status       = $request->status;
                $unit->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/unit')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }
            DB::commit();

            session()->flash("success", 'Unit '.$unit->name.' created successfully.');
            return redirect()->route("unit.index");
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function show(Unit $unit)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function edit(Unit $unit)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        return view('backend.unit.edit',compact('unit'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Model\Unit  $unit
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Unit $unit)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            'name' => 'required|max:250',
            'value' => 'required',
            'description' => 'max:500',
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
                $unit->name         = $request->name;
                $unit->value         = $request->value;
                $unit->description  = $request->description;
                $unit->status       = $request->status;
                $unit->save();
            }catch(ValidationException $e) {
                DB::rollback();
                return Redirect::to('/unit')
                    ->withErrors( $e->getErrors() )
                    ->withInput();
            }catch(\Exception $e)
            {
                DB::rollback();
                throw $e;
            }

            DB::commit();

            session()->flash("success", 'Unit '.$unit->name.' updated successfully.');
            return redirect()->route("unit.index");

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Model\Warehouse  $role
     * @return \Illuminate\Http\Response
     */
    /*public function destroy(Warehouse $warehouse)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        if ($warehouse->Delete()){
            session()->flash("success","Warehouse Deleted");
            return redirect()->back();
        }else{
            session()->flash("error","Warehouse not Deleted");
            return redirect()->back();
        }
    }*/

}
