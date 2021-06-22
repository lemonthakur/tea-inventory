<?php

namespace App\Http\Controllers;

use App\Models\MailReceiver;
use App\Models\Product;
use App\Models\Product_Warehouse;
use App\Models\SiteSetting;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class MailReceiverController extends Controller
{
    public function index(){
        $receivers = MailReceiver::with('user','user.role')->orderBy('id','desc')->paginate(20);
        $users = User::with('role')->orderBy('name')->where('status','1')->get();
        return view('backend.mail-receiver.index',compact('receivers','users'));
    }

    public function store(Request $request){
        $rules = [
            "employeeIds" => "required"
        ];

        $message = [
            "employeeIds.required" => "Employee is required",
        ];

        $validation = Validator::make($request->all(), $rules, $message);

        if ($validation->fails()) {
            return redirect()->back()->withInput()->withErrors($validation);
        }
        $c = 0;
        foreach ($request->employeeIds as $user_id){
            $isMailReceiver = MailReceiver::where('user_id',$user_id)->first();
            if (!$isMailReceiver){
                $mailReceiver = new MailReceiver();
                $mailReceiver->user_id = $user_id;
                $mailReceiver->save();
                $c++;
            }
        }
        session()->flash('success','Total '. $c .' mail receiver added');
        return redirect()->route('email-receiver.index');
    }

    public function destroy($id){
        $mailReceiver = MailReceiver::find($id);
        if ($mailReceiver->delete()){
            session()->flash('success','Mail receiver deleted');
        }else{
            session()->flash('error','Mail receiver not deleted');
        }
        return redirect()->route('email-receiver.index');
    }
}
