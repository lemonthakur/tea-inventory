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
                                    <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                                    <a href="{{$reportUrl.'&action=csv'}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                                </p>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <form method="get" action="{{route('product-stock.get')}}">
                                    @csrf
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group select2-parent">
                                                <label for="product">Product</label>
                                                <select name="product_ser" class="form-control search-product" style="width: 100%;" data-allow-clear="true" data-url="{{route('ser-product.get')}}">
                                                    <option></option>
                                                </select>
                                                <input type="hidden" id="productProduceRoute" value="{{route('ser-product.get')}}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
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
                                        <div class="col-md-3">
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
                                        <th>Adjust In</th>
                                        <th>Adjust Out</th>
                                        <th>Production</th>
                                        <th>Used in Production</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($products as $product)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ $product->code }}</td>
                                            <td>{{ $product->name }}</td>
                                            <td>
                                                @php
                                                    $order = \App\Models\ProductPurchase::where('product_id', $product->id);
                                                @endphp
                                            </td>
                                            <td class="text-right">{{ number_format($product->qty/$product->unit_value, 2) }}</td>
                                            <td class="text-right">{{ number_format($product->total, 2) }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="6" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse
                                            <?php
                                                $site_unit_val = ($site_unit) ? $site_unit->value : 1;
                                                $site_unit_name = ($site_unit) ? $site_unit->name : '';
                                            ?>
                                        <tr>
                                            <td colspan="4" class="text-right"><b>Total</b></td>
                                            <td class="text-right"><b>{{number_format($total_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_price, 2)}}</b></td>
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
