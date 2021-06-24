@extends("backend.master.main-layout")
@section("page-title","Quantity Report")
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
                                <h3 class="card-title" style="margin-left: 45% !important;">Quantity Report</h3>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                @csrf
                                <form method="get" action="{{route('low-quantity.get')}}">
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

                                        <div class="col-md-2">
                                            <div class="form-group select2-parent">
                                                <label for="quantity">Quantity Less Than</label>
                                                <input type="number"
                                                    class="form-control" placeholder="Give Quantity"
                                                    id="quantity" name="quantity" min="0" step="any" value="{{request()->query('quantity')}}"/>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group select2-parent">
                                                <label for="warehouse">Order By Quantity</label>
                                                <select
                                                    class="form-control"
                                                    data-placeholder="Select Order By" data-allow-clear="true"
                                                    id="orderBy" name="order_by">
                                                    <option  @if(request()->query('order_by') == 'asc') selected @endif value="asc">Ascending</option>
                                                    <option  @if(request()->query('order_by') == 'desc') selected @endif value="desc">Descending</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group text-right" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route("low-quantity.get")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="col-md-12 text-right">
{{--                                    <a href="{{route('low-quantity.print').'?'.http_build_query(request()->query())}}" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></a>--}}
                                    <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                                    <a href="{{route('low-quantity.excel').'?'.http_build_query(request()->query())}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                                </div>
                            </div>

                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive" id="prin-table">
                                <span>Displaying Order from {{ ($products->total()) ? $sl+1 : 0 }} to {{ $sl+$products->count() }} out of total {{ $products->total() }}</span>

                                <table class="table table-bordered production-table">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Product Name</th>
                                        <th>Qty</th>
                                        <th>Unit</th>
                                        <th>Warehouse</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($products as $product)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ ucwords($product->product_name) }}</td>
                                            <td class="text-right">{{ number_format($product->product_warehouse_qty, 2) }}</td>
                                            <td>{{ $product->unit_name }}</td>
                                            <td>{{ ucwords($product->warehouse_name) }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="11" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse

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
                    '</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
