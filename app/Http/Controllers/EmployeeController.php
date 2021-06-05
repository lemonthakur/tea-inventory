<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Role;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class EmployeeController extends Controller
{

    public function index(){
        $users = User::with(['role:id,name','creator:id,name','updator:id,name'])
            ->where('id','!=', 1)
            ->where('isEmployee','=', 1)
            ->orderBy('id','desc')
            ->paginate(20);

        $paginate = OwnLibrary::paginationSerial($users);

        return view('backend.employee.index',compact('users','paginate'));
    }

    public function create(){
        return view('backend.employee.create');
    }
    public function store(Request $request){
        $rules = [
            'name' => 'required|max:190',
            'email' => 'required|email|unique:users|max:100',
            'contact_no' => 'required|unique:users|max:15',
            'designation' => 'required|max:100',
            'password' => 'required|min:5',
            'confirm_password' => 'required|same:password|min:5',
            'photo' => 'image'
        ];

        $message = [];

        $validation = Validator::make($request->all(),$rules,$message);

        if ($validation->fails()){
            return redirect()->back()
                ->withInput()
                ->withErrors($validation);
        }else{
            $user = new User();
            $user->role_id = 0;
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
        return view('backend.employee.edit',compact('employee'));
    }

    public function update(Request $request, User $employee){
        $rules = [
            'name' => 'required|max:190',
            'email' => 'required|email|max:190|unique:users,email,' . $employee->id,
            'contact_no' => 'required||max:15|unique:users,contact_no,' . $employee->id,
            'designation' => 'required|max:100',
            'photo' => 'image'
        ];

        $message = [];

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
