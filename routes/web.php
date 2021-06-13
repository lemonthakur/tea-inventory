<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\PurchaseController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\UserAccessController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ModuleController;
use App\Http\Controllers\RoleAccessController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AdminLoginController;
use App\Http\Controllers\ActivityController;
use App\Http\Controllers\SiteSettingController;
use App\Http\Controllers\WarehouseController;
use App\Http\Controllers\UnitController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\ProductController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/',[AdminLoginController::class,'loginView'])->name('admin.login.view');
Route::get('/admin-login',[AdminLoginController::class,'loginView'])->name('admin.login.view');
Route::post('/admin-login',[AdminLoginController::class,'login'])->name('admin.login');

Route::group(['middleware'=>'authCheck'],function (){
    Route::get('/admin-logout',[AdminLoginController::class,'logout'])->name('admin.logout');

    Route::get("/dashboard",[DashboardController::class,'index'])->name('dashboard');

    Route::resources([
        'activity' => ActivityController::class,
        'module' => ModuleController::class,
        'role' => RoleController::class,
        'user' => UserController::class,
        'categories' => CategoryController::class,
        'suppliers' => SupplierController::class,
        'employees' => EmployeeController::class,
    ]);

    Route::get('site-setting',[SiteSettingController::class,'edit'])->name('site.setting.edit');
    Route::put('site-setting', [SiteSettingController::class,'update'])->name('site.setting.update');

    Route::get('role-access',[RoleAccessController::class,'index'])->name('role.access');
    Route::post('roleAclSetup', [RoleAccessController::class,'roleAclSetup']);
    Route::post('roleacl', [RoleAccessController::class,'save']);

    Route::get('user-access', [UserAccessController::class,'index'])->name('user.access');
    Route::post('userAclSetup', [UserAccessController::class,'userAclSetup']);
    Route::post('useracl', [UserAccessController::class,'save']);

    # Warehouse
    Route::resource("/warehouse",WarehouseController::class);
    Route::resource("/unit",UnitController::class);
    Route::resource("/brand",BrandController::class);

    #product
    Route::resource("/product",ProductController::class);
    Route::get('/gencode', [ProductController::class,'generateCode']);
    Route::get('peodut-file-download/{id}', [ProductController::class,'peodutFileDownload'])->name('peodutFile.download');
    Route::post('/ser-product-get', [ProductController::class,'search'])->name('ser-product.get');
    Route::post('/product-wise-row-get', [ProductController::class,'product_wise_row_get'])->name('product-wise-row.get');
    Route::post('/product-warehouse-qty-get', [ProductController::class,'product_warehouse_qty_get'])->name('product-warehouse-qty.get');
    Route::get('/products/print-barcode',[ProductController::class, 'printBarcode'])->name('product.printBarcode');
    Route::post('/products/produc-wise-row-short-get',[ProductController::class, 'product_wise_row_short_get'])->name('produc-wise-row-short.get');

    //Route::get('/purchase/create', [PurchaseController::class,'create'])->name('purchase.create');
    Route::resource("/purchase",PurchaseController::class);
    Route::post('/purchase-details-get', [PurchaseController::class,'purchase_details_get'])->name('purchase-details.get');
    Route::get('purchase-document-download/{id}', [PurchaseController::class,'purchaseFileDownload'])->name('purchaseFile.download');
});

