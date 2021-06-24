<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Form;
use App\Models\FormSubmit;
use App\Models\Product;
use App\Models\Product_Warehouse;
use App\Models\Purchase;
use App\Models\User;
use App\Models\Warehouse;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(){
        $user_ware_house = OwnLibrary::user_warehosue();
        $userCount = User::count() -1;
        if ($user_ware_house){
            $warehouseCount = count($user_ware_house);
            $productCount = Product::whereNotNull('products.id')
                ->join('product_warehouse', 'product_warehouse.product_id' ,'=', 'products.id')
                ->whereIn('product_warehouse.warehouse_id', $user_ware_house)
                ->count();
            $purchasesCount = Purchase::whereNotNull('id')->whereIn('warehouse_id', $user_ware_house)->count();
        }else{
            $warehouseCount = Warehouse::count();
            $productCount = Product::count();
            $purchasesCount = Purchase::whereNotNull('id')->count();
        }


//        dd($userCount);
        return view("backend.dashboard.index",
            compact('userCount','productCount','warehouseCount','purchasesCount'));
    }
}
