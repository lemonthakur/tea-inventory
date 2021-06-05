<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Supplier;
use Illuminate\Http\Request;

class SupplierController extends Controller
{
    public function index()
    {
        $suppliers = Supplier::orderBy('id','DESC')->paginate(20);
        $paginate = OwnLibrary::paginationSerial($suppliers);
        return view('backend.supplier.index',compact('suppliers','paginate'));
    }


    public function create()
    {
        return view('backend.supplier.create');
    }

    public function store(Request $request)
    {
        $rules = [
            'name' => 'required|max:250',
            'email' => 'required|email|max:250',
            'contact_no' => 'required|min:11|max:30',
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
        return view('backend.supplier.edit',compact('supplier'));
    }

    public function update(Request $request, Supplier $supplier)
    {
        $rules = [
            'name' => 'required|max:250',
            'email' => 'required|email|max:250',
            'contact_no' => 'required|min:11|max:30',
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
        if ($supplier->delete()){
            session()->flash("success", "Data deleted");
        }else{
            session()->flash("error", "Data unable to delete");
        }
        return redirect()->route("suppliers.index");
    }
}