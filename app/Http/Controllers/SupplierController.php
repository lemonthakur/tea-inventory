<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Supplier;
use Illuminate\Http\Request;

class SupplierController extends Controller
{
    protected $moduleId = 20;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);
        $suppliers = Supplier::whereNotNull('id');
        if($request->input('q')){
            $q = $request->input('q');
            $suppliers->where(function($query) use($q){
                $query->where('name', 'like', '%' . $q . '%');
                $query->orWhere('contact_no', 'like', '%' . $q . '%');
                $query->orWhere('email', 'like', '%' . $q . '%');
            });
        }
        $suppliers = $suppliers->orderBy('id','DESC')->paginate(20);

        $paginate = OwnLibrary::paginationSerial($suppliers);
        return view('backend.supplier.index',compact('suppliers','paginate'));
    }


    public function create()
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        return view('backend.supplier.create');
    }

    public function store(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,2);
        $rules = [
            'name' => 'required|max:250',
            'email' => 'required|email|max:250',
            'contact_no' => 'required|max:30',
            'address' => 'max:500',
        ];

        $message = [];

        $validator = validator($request->all(),$rules,$message);

        if ($validator->fails()){
            return redirect()->back()->withInput()->withErrors($validator);
        }

        $supplier = new Supplier();
        $supplier->name = $request->name;
        $supplier->email = $request->email;
        $supplier->contact_no = $request->contact_no;
        $supplier->address = $request->address;

        if ($supplier->save()){
            session()->flash("success", "Data successfully created");
            return redirect()->route("suppliers.index");
        }else{
            session()->flash("error", "Data not created");
            return redirect()->back()->withInput();
        }

    }

    public function edit(Supplier $supplier)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        return view('backend.supplier.edit',compact('supplier'));
    }

    public function update(Request $request, Supplier $supplier)
    {
        OwnLibrary::validateAccess($this->moduleId,3);
        $rules = [
            'name' => 'required|max:250',
            'email' => 'required|email|max:250',
            'contact_no' => 'required|max:30',
            'address' => 'max:500',
        ];

        $message = [];

        $validator = validator($request->all(),$rules,$message);

        if ($validator->fails()){
            return redirect()->back()->withInput()->withErrors($validator);
        }

        $supplier->name = $request->name;
        $supplier->email = $request->email;
        $supplier->contact_no = $request->contact_no;
        $supplier->address = $request->address;
        $supplier->status = $request->status;

        if ($supplier->save()){
            session()->flash("success", "Data successfully created");
            return redirect()->route("suppliers.index");
        }else{
            session()->flash("error", "Data not created");
            return redirect()->back()->withInput();
        }
    }

    public function destroy(Supplier $supplier)
    {
        OwnLibrary::validateAccess($this->moduleId,4);
        if ($supplier->delete()){
            session()->flash("success", "Data deleted");
        }else{
            session()->flash("error", "Data unable to delete");
        }
        return redirect()->route("suppliers.index");
    }
}
