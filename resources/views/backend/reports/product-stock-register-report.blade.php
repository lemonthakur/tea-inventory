@extends("backend.master.main-layout")
@section("page-title","Stock Register Report")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="margin-left: 45% !important;">Stock Register Report</h3>
                                <p style="margin-left: 95% !important;">
                                    @if(!empty($aclList[31][7]))
                                    <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                                        @endif
                                        @if(!empty($aclList[31][9]))
                                        <a href="{{$reportUrl.'&action=csv'.'&page='.request()->query('page')}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                                        @endif
                                </p>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <form method="get" action="{{route('product-register-stock.get')}}">
                                    @csrf
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group select2-parent">
                                                <label for="product">Product</label>
                                                <select name="product_ser" class="form-control search-product" style="width: 100%;" data-allow-clear="true" data-url="{{route('ser-product.get')}}">
                                                    <option></option>
                                                </select>
                                                <input type="hidden" id="productProduceRoute" value="{{route('ser-product.get')}}">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group select2-parent">
                                                <label for="warehouse">Warehouse</label>
                                                <select
                                                        class="form-control single-select2"
                                                        data-placeholder="Select Warehouse" data-allow-clear="true"
                                                        id="warehouse_ser" name="warehouse_ser">
                                                    <option></option>
                                                    @foreach($warehouses as $warehouse)
                                                        <option value="{{$warehouse->id}}" @if(request()->query('warehouse_ser') == $warehouse->id) selected @endif>{{ucwords($warehouse->name)}}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="name">Start Date</label>
                                                <input type="text" class="form-control datepicker" id="start_date" name="start_date" value="{{request()->query('start_date')}}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="name">End Date</label>
                                                <input type="text" class="form-control datepicker" id="end_date" name="end_date" value="{{request()->query('end_date')}}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group select2-parent">
                                                <label for="warehouse">Order by</label>
                                                <select
                                                    class="form-control single-select2"
                                                    data-placeholder="Select order" data-allow-clear="true"
                                                    id="order_by_ser" name="order_by_ser">
                                                    <option></option>
                                                    <option value="asc" @if(request()->query('order_by_ser') == 'asc') selected @endif>Lower to high</option>
                                                    <option value="desc" @if(request()->query('order_by_ser') == 'desc') selected @endif>Higher to low</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route("product-register-stock.get")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive" id="prin-table">
                                <span id="count_pan">Displaying product from {{ ($products->total()) ? $sl+1 : 0 }} to {{ $sl+$products->count() }} out of total {{ $products->total() }}</span>
                                <table class="table table-bordered production-table">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Order Qty</th>
                                        <th>Transfer In</th>
                                        <th>Transfer Out</th>
                                        <th>Adjust Addition</th>
                                        <th>Adjust Subtraction</th>
                                        <th>Production</th>
                                        <th>Used in Production</th>
                                        <th>In Stock</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                        $total_order_qty = 0;
                                        $total_transfer_in_qty = 0;
                                        $total_transfer_out_qty = 0;
                                        $total_adjust_in_qty = 0;
                                        $total_adjust_out_qty = 0;
                                        $total_production_qty = 0;
                                        $total_used_in_production_qty = 0;

                                        $site_unit_val = ($site_unit) ? $site_unit->value : 1;
                                        $site_unit_name = ($site_unit) ? $site_unit->name : '';
                                    ?>
                                    @forelse($products as $product)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ $product->code }}</td>
                                            <td>{{ $product->name }}</td>
                                            <td class="text-right">
                                                @php
                                                    $order = \App\Models\ProductPurchase::join('purchases', 'purchases.id','=','product_purchases.purchase_id')
                                                            ->where('product_purchases.product_id', $product->id);
                                                            if($user_ware_house)
                                                                $order->whereIn('warehouse_id', $user_ware_house);
                                                            if(request()->query('purchases.warehouse_ser'))
                                                                $order->where('warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $order->whereDate('product_purchases.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $order->whereDate('product_purchases.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $order_qty = $order->sum('product_purchases.qty');
                                                    $total_order_qty += $order_qty;
                                                @endphp
                                                {{ number_format($order_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $transfer_in = \App\Models\ProductTransfer::join('transfers', 'transfers.id','=','product_transfer.transfer_id')
                                                            ->where('product_id', $product->id);
                                                            if($user_ware_house)
                                                                $transfer_in->whereIn('to_warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $transfer_in->where('to_warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $transfer_in->whereDate('product_transfer.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $transfer_in->whereDate('product_transfer.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $transfer_in_qty = $transfer_in->sum('product_transfer.qty');
                                                    if(request()->query('warehouse_ser') || $user_ware_house)
                                                        $total_transfer_in_qty += $transfer_in_qty;
                                                    else
                                                        $total_transfer_in_qty = $transfer_in_qty = 0;
                                                @endphp
                                                    {{ number_format($transfer_in_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $transfer_out = \App\Models\ProductTransfer::join('transfers', 'transfers.id','=','product_transfer.transfer_id')
                                                            ->where('product_id', $product->id);
                                                            if($user_ware_house)
                                                                $transfer_out->whereIn('from_warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $transfer_out->where('from_warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $transfer_out->whereDate('product_transfer.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $transfer_out->whereDate('product_transfer.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $transfer_out_qty = $transfer_out->sum('qty');
                                                    if(request()->query('warehouse_ser') || $user_ware_house)
                                                        $total_transfer_out_qty += $transfer_out_qty;
                                                    else
                                                        $total_transfer_out_qty = $transfer_out_qty = 0;
                                                @endphp
                                                    {{ number_format($transfer_out_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $adjust_in = \App\Models\ProductAdjustment::join('adjustments', 'adjustments.id','=','product_adjustments.adjustment_id')
                                                            ->where('product_id', $product->id)
                                                            ->where('action', '+');
                                                            if($user_ware_house)
                                                                $adjust_in->whereIn('warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $adjust_in->where('warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $adjust_in->whereDate('product_adjustments.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $adjust_in->whereDate('product_adjustments.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $adjust_in_qty = $adjust_in->sum('product_adjustments.qty');
                                                    $total_adjust_in_qty += $adjust_in_qty;
                                                @endphp
                                                    {{ number_format($adjust_in_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $adjust_out = \App\Models\ProductAdjustment::join('adjustments', 'adjustments.id','=','product_adjustments.adjustment_id')
                                                            ->where('product_id', $product->id)
                                                            ->where('action', '-');
                                                            if($user_ware_house)
                                                                $adjust_out->whereIn('warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $adjust_out->where('warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $adjust_out->whereDate('product_adjustments.created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $adjust_out->whereDate('product_adjustments.created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $adjust_out_qty = $adjust_out->sum('product_adjustments.qty');
                                                    $total_adjust_out_qty += $adjust_out_qty;
                                                @endphp
                                                {{ number_format($adjust_out_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $production = \App\Models\Production::where('status', 1)
                                                            ->where('product_id', $product->id);
                                                            if($user_ware_house)
                                                                $production->whereIn('warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $production->where('warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $production->whereDate('created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $production->whereDate('created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $production_qty = $production->sum('produce_amount');
                                                    $total_production_qty += $production_qty;
                                                @endphp
                                                {{ number_format($production_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right">
                                                @php
                                                    $used_in_production = \App\Models\ProductionUseProduct::whereNotNull('id')
                                                            ->where('product_id', $product->id);
                                                            if($user_ware_house)
                                                                $used_in_production->whereIn('warehouse_id', $user_ware_house);
                                                            if(request()->query('warehouse_ser'))
                                                                $used_in_production->where('warehouse_id','=', request()->query('warehouse_ser'));
                                                            if(request()->query('start_date'))
                                                                $used_in_production->whereDate('created_at','>=', date("Y-m-d", strtotime(request()->input('start_date'))));
                                                            if(request()->query('end_date'))
                                                                $used_in_production->whereDate('created_at','<=', date("Y-m-d", strtotime(request()->input('end_date'))));
                                                    $used_in_production_qty = $used_in_production->sum('qty');
                                                    $total_used_in_production_qty += $used_in_production_qty;
                                                @endphp
                                                {{ number_format($used_in_production_qty/$product->unit_value, 2)}}
                                            </td>
                                            <td class="text-right @if(( ($order_qty+$transfer_in_qty+$adjust_in_qty+$production_qty) - ($transfer_out_qty+$adjust_out_qty+$used_in_production_qty) )/$site_unit_val <= $site_setting->alert_quantity/$site_unit_val){{'bg-warning'}} @endif">{{ number_format((($order_qty+$transfer_in_qty+$adjust_in_qty+$production_qty) - ($transfer_out_qty+$adjust_out_qty+$used_in_production_qty))/$site_unit_val, 2) }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="6" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse
                                        <tr>
                                            <td colspan="3" class="text-right"><b>Total</b></td>
                                            <td class="text-right"><b>{{number_format($total_order_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_transfer_in_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_transfer_out_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_adjust_in_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_adjust_out_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_production_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_used_in_production_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{ number_format((($total_order_qty+$total_transfer_in_qty+$total_adjust_in_qty+$total_production_qty) -
                                                        ($total_transfer_out_qty+$total_adjust_out_qty+$total_used_in_production_qty))/$site_unit_val, 2) }}&nbsp;{{$site_unit_name}}</b></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{ $products->appends(\Request::except('page'))->links("backend.include.pagination") }}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection

@section('js')
    <script type="text/javascript">
        $(document).ready(function () {

            $("#print-btn").on("click", function() {
                var divToPrint=document.getElementById('prin-table');
                var newWin=window.open('','Print-Window');
                newWin.document.open();
                newWin.document.write('<style type="text/css">@media  print' +
                    ' table.production-table { page-break-inside:auto; }' +
                    ' table.production-table tr { page-break-inside:avoid; page-break-after:auto;}' +
                    ' table.production-table {border: 1px solid black;border-collapse: collapse;width: 100%}' +
                    ' table.production-table th {border: 1px solid black;text-align: left;padding: 2px 5px; vertical-align: middle}' +
                    ' table.production-table td {border: 1px solid black;text-align: left;padding: 2px 5px;vertical-align: middle}' +
                    ' #count_pan {visibility: hidden}' +
                    '</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
