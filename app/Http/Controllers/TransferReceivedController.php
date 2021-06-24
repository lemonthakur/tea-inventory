<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Warehouse;
use App\Models\Supplier;
use App\Models\Product;
use App\Models\Unit;
use App\Models\Purchase;
use App\Models\ProductPurchase;
use App\Models\Product_Warehouse;
use App\Models\User;
use App\Models\Transfer;
use App\Models\ProductTransfer;
use DB;
use Auth;

class TransferReceivedController extends Controller
{
    protected $moduleId = 17;
    public function index(Request $request)
    {
        OwnLibrary::validateAccess($this->moduleId,1);

        $user_ware_house = OwnLibrary::user_warehosue();
        $transfers = Transfer::whereNotNull('id');
        if($user_ware_house){
            $transfers->whereIn('to_warehouse_id', $user_ware_house);
        }
        if($request->input('product_ser')){
            $product_id = $request->input('product_ser');
            $transfers->whereHas('transfer_details', function($query) use($product_id) {
                $query->where('product_id', $product_id);
            });
        }
        if($request->input('start_date'))
            $transfers->whereDate('created_at','>=', date("Y-m-d", strtotime($request->input('start_date'))));
        if($request->input('end_date'))
            $transfers->whereDate('created_at','<=', date("Y-m-d", strtotime($request->input('end_date'))));

        $transfers->orderBy('id','DESC');
        $transfers = $transfers->paginate(20);

        return view('backend.transfer.transfer-received', compact('transfers'));
    }

}
