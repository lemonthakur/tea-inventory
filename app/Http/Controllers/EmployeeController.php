<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\EmployeeWarhouse;
use App\Models\Role;
use App\Models\User;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class EmployeeController extends Controller
{

    public function index(){
        $users = User::with(['role:id,name','creator:id,name','updator:id,name'])
            ->where('id','!=', 1)
//            ->where('isEmployee','=', 0)
            ->orderBy('name')
            ->paginate(20);

        $paginate = OwnLibrary::paginationSerial($users);

        return view('backend.employee.index',compact('users','paginate'));
    }

    public function create(){
        $warehouses = Warehouse::select('id','name')->where('status','=',1)->orderBy('name')->get();
        $roles = Role::select('id','name')->where('status','=',1)->where('id','!=', 1)->get();
        return view('backend.employee.create',compact('roles','warehouses'));
    }
    public function store(Request $request){
        $rules = [
            'name' => 'required|max:190',
            'email' => 'required|email|unique:users|max:100',
            'contact_no' => 'required|unique:users|max:15',
            'role_id' => 'required',
            'password' => 'required|min:5',
            'confirm_password' => 'required|same:password|min:5',
            'photo' => 'image'
        ];

        $message = [
            'role_id.required' => 'Designation is required',
        ];

        $validation = Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()
                ->withInput()
                ->withErrors($validation);
        }else{
            $user = new User();
            $user->role_id = $request->role_id;
            $user->name = $request->name;
            $user->email = $request->email;
            $user->contact_no = $request->contact_no;
            $user->designation = $request->designation;
            $user->isEmployee = 1;
            $user->password = Hash::make($request->password);

            $image = $request->file('photo');

            if ($image) {
                $image_name = Str::random(20);
                $ext = strtolower($image->getClientOriginalExtension());
                $image_full_name = $image_name . '.' . $ext;
                $upload_path = 'public/upload/employee/';
                $image_url = $upload_path . $image_full_name;
                $image->move($upload_path, $image_full_name);
                $user->photo = $image_url;
            }


            if ($user->save()){
                $eid = $user->id;
                if (!empty($request->warehouse_id)){
                    foreach ($request->warehouse_id as $key => $value){
                        $warehouse = new EmployeeWarhouse();
                        $warehouse->user_id = $eid;
                        $warehouse->warehouse_id = $value;
                        $warehouse->save();
                    }
                }
                session()->flash("success","Data Added");
                return redirect()->route("employees.index");
            }else{
                session()->flash("error","Data Not Added");
                return redirect()->back()->withInput();
            }
        }
    }

    public function show(User $user)
    {
        //
    }

    public function edit(User $employee){
        $roles = Role::select('id','name')->where('status','=',1)->where('id','!=', 1)->get();
        $warehouses = Warehouse::select('id','name')->where('status','=',1)->orderBy('name')->get();
        $employeeWarehouses = EmployeeWarhouse::select('warehouse_id')->where('user_id','=',$employee->id)->get()->toArray();
        $employeeWarehouses = array_column($employeeWarehouses,'warehouse_id');
        return view('backend.employee.edit',compact('employee','roles','warehouses','employeeWarehouses'));
    }

    public function update(Request $request, User $employee){
        $rules = [
            'name' => 'required|max:190',
            'email' => 'required|email|max:190|unique:users,email,' . $employee->id,
            'contact_no' => 'required||max:15|unique:users,contact_no,' . $employee->id,
            'role_id' => 'required',
            'photo' => 'image'
        ];

        $message = [
            'role_id.required' => 'Designation is required',
        ];

        if (!empty($request->password)){
            $rules['password'] = 'required|min:5';
            $rules['confirm_password'] = 'required|same:password|min:5';
        }

        $validation = Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()
                ->withInput()
                ->withErrors($validation);
        }else{
            $employee->role_id = $request->role_id;
            $employee->name = $request->name;
            $employee->email = $request->email;
            $employee->contact_no = $request->contact_no;
            $employee->status = $request->status;
            if(!empty($request->password)){
                $employee->password = Hash::make($request->password);
            }

            $image = $request->file('photo');

            if ($image) {
                if ($employee->photo){
                    @unlink($employee->photo);
                }
                $image_name = Str::random(20);
                $ext = strtolower($image->getClientOriginalExtension());
                $image_full_name = $image_name . '.' . $ext;
                $upload_path = 'public/upload/portfolio-pic/';
                $image_url = $upload_path . $image_full_name;
                $image->move($upload_path, $image_full_name);
                $employee->photo = $image_url;
            }

                $warehouseDelete = EmployeeWarhouse::where('user_id',$employee->id)->delete();

            if (!empty(($request->warehouse_id)) && !empty(($request->warehouse_id[0])) ){
                foreach ($request->warehouse_id as $key => $value){
                    $warehouse = new EmployeeWarhouse();
                    $warehouse->user_id = $employee->id;
                    $warehouse->warehouse_id = $value;
                    $warehouse->save();
                }
            }

            if ($employee->save()){
                session()->flash("success","Data Updated");
                return redirect()->route("employees.index");
            }else{
                session()->flash("error","Data Not Updated");
                return redirect()->back()->withInput();
            }
        }
    }

    public function destroy(User $employee){
        if ($employee->delete()){
            session()->flash('success','Data Delated');
        }else{
            session()->flash('error','Data Delated');
        }
        return redirect()->back();
    }
}
