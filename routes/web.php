<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\LowQuantityReportController;
use App\Http\Controllers\MailReceiverController;
use App\Http\Controllers\ProductionController;
use App\Http\Controllers\ProductionReportController;
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
use App\Http\Controllers\TransferController;
use App\Http\Controllers\AdjustmentController;
use App\Http\Controllers\TransferReceivedController;
use App\Http\Controllers\OrderReportController;
use App\Http\Controllers\TransferReportController;
use App\Http\Controllers\ReceiveTransferReportController;
use App\Http\Controllers\ProductStockReportController;
use App\Http\Controllers\ProductStockRegistersReportController;
use App\Http\Controllers\ProductAdjustmentReportController;
use App\Http\Controllers\ProductHistoryController;
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
    Route::post('/employees-get', [EmployeeController::class,'getEmployee'])->name('employee.get');
    Route::get('/employee-change-password', [EmployeeController::class,'changePasswordView'])->name('employee.change-password');
    Route::post('/employee-change-password', [EmployeeController::class,'changePassword'])->name('employee.change-password.store');

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
    Route::any('/ser-product-get', [ProductController::class,'search'])->name('ser-product.get');
    Route::post('/product-wise-row-get', [ProductController::class,'product_wise_row_get'])->name('product-wise-row.get');
    Route::post('/product-warehouse-qty-get', [ProductController::class,'product_warehouse_qty_get'])->name('product-warehouse-qty.get');
    Route::get('/products/print-barcode',[ProductController::class, 'printBarcode'])->name('product.printBarcode');
    Route::post('/products/produc-wise-row-short-get',[ProductController::class, 'product_wise_row_short_get'])->name('produc-wise-row-short.get');

    //Route::get('/purchase/create', [PurchaseController::class,'create'])->name('purchase.create');
    Route::resource("/order",PurchaseController::class);
    Route::post('/order-details-get', [PurchaseController::class,'purchase_details_get'])->name('order-details.get');
    Route::get('order-document-download/{id}', [PurchaseController::class,'purchaseFileDownload'])->name('orderFile.download');
    Route::get('order-received/{id}', [PurchaseController::class,'orderReceived'])->name('order.received');
    Route::get('order-label/{id}', [PurchaseController::class,'orderLabel'])->name('order.label');

    // Transfer
    Route::resource("/transfer",TransferController::class);
    Route::post("/transfer/get-product",[TransferController::class,'getProduct'])->name('transfer.get-product');
    Route::post("/transfer/get-available-qty",[TransferController::class,'getProductQty'])->name('transfer.get-available-qty');
    Route::post('/transfer-details-get', [TransferController::class,'transfer_details_get'])->name('transfer-details.get');
    Route::get('transfer-document-download/{id}', [TransferController::class,'transferFileDownload'])->name('transfer-purchaseFile.download');

    Route::resource("/transfer-received",TransferReceivedController::class);
    // Adjustment
    Route::resource("/qty_adjustment",AdjustmentController::class);
    Route::post('adjustment/product-warehouse-qty-get', [AdjustmentController::class,'adjustment_product_warehouse_qty_get'])->name('adjustment-product-warehouse-qty.get');
    Route::post("/adjustment/get-product",[AdjustmentController::class,'getProduct'])->name('adjustment.get-product');
    Route::get('adjustment-document-download/{id}', [AdjustmentController::class,'adjustmentFileDownload'])->name('adjustmentFile.download');

    Route::post('/employees-get', [EmployeeController::class,'getEmployee'])->name('employee.get');

    //Production
    Route::get('productions',[ProductionController::class,'index'])->name('production.index');
    Route::get('productions/create',[ProductionController::class,'create'])->name('production.create');
    Route::post('productions',[ProductionController::class,'store'])->name('production.store');
    Route::get('productions/{id}',[ProductionController::class,'show'])->name('production.show');
    Route::get('productions/{id}/edit',[ProductionController::class,'edit'])->name('production.edit');
    Route::put('productions/{id}',[ProductionController::class,'update'])->name('production.update');
    Route::post('productions/add-to-cart',[ProductionController::class,'cartAdd'])->name('production.add.cart');
    Route::post('productions/remove-cart',[ProductionController::class,'removeCart'])->name('production.remove.cart');

    // Order report
    Route::any('report/order-report',[OrderReportController::class,'index'])->name('order-report.get');
    Route::get('order-report-excel',[OrderReportController::class,'orderReportExcel']);

    // Transfer report
    Route::any('report/transfer-report',[TransferReportController::class,'index'])->name('transfer-report.get');
    Route::get('transfer-report-excel',[TransferReportController::class,'transferReportExcel']);

    // Transfer received
    Route::any('report/receive-transfer-report',[ReceiveTransferReportController::class,'index'])->name('receive-transfer-report.get');
    Route::get('receive-transfer-report-excel',[ReceiveTransferReportController::class,'receiveTransferReportExcel']);

    // Transfer received
    Route::any('report/receive-transfer-report',[ReceiveTransferReportController::class,'index'])->name('receive-transfer-report.get');
    Route::get('receive-transfer-report-excel',[ReceiveTransferReportController::class,'receiveTransferReportExcel']);

    // Product stock report
    Route::any('report/product-stock',[ProductStockReportController::class,'index'])->name('product-stock.get');
    Route::get('product-stock-report-excel',[ProductStockReportController::class,'productStockReportExcel']);

    // Stock register report
    Route::any('report/product-register-stock',[ProductStockRegistersReportController::class,'index'])->name('product-register-stock.get');
    Route::get('product-register-stock-report-excel',[ProductStockRegistersReportController::class,'productRegisterStockReportExcel']);

    // adjustment report
    Route::any('report/product-adjustment',[ProductAdjustmentReportController::class,'index'])->name('product-adjustment.get');
    Route::get('product-adjustment-excel',[ProductAdjustmentReportController::class,'productAdjustmentkReportExcel']);

//    Email receiver list
    Route::get('email-receivers',[MailReceiverController::class,'index'])->name('email-receiver.index');
    Route::post('email-receivers',[MailReceiverController::class,'store'])->name('email-receiver.store');
    Route::delete('email-receivers/{id}',[MailReceiverController::class,'destroy'])->name('email-receiver.destroy');

//  Quantity report
    Route::any('low-quantity-report/index',[LowQuantityReportController::class,'index'])->name('low-quantity.get');
    Route::get('low-quantity-report/excel',[LowQuantityReportController::class,'excel'])->name('low-quantity.excel');
    Route::get('low-quantity-report/print',[LowQuantityReportController::class,'print'])->name('low-quantity.print');

//    Production Report
    Route::any('prodcution-report/index',[ProductionReportController::class,'index'])->name('production-report.get');
    Route::get('prodcution-report/excel',[ProductionReportController::class,'excel'])->name('production-report.excel');

//    product history report
    Route::any('product-history/index',[ProductHistoryController::class,'index'])->name('product-history.get');
    Route::get('product-history-excel',[ProductHistoryController::class,'excel']);
});

