@extends("backend.master.main-layout")
@section("page-title","Adjustment Report")
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
                                <h3 class="card-title" style="margin-left: 45% !important;">Adjustment Report</h3>
                                <p style="margin-left: 95% !important;">
                                    @if(!empty($aclList[32][7]))
                                    <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                                      @endif
                                        @if(!empty($aclList[32][9]))
                                        <a href="{{$reportUrl.'&action=csv'}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                                        @endif
                                </p>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <form method="get" action="{{route('product-adjustment.get')}}">
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
                                                <label for="warehouse">Action</label>
                                                <select
                                                        class="form-control"
                                                        data-placeholder="Select action" data-allow-clear="true"
                                                        id="action_ser" name="action_ser">
                                                    <option>All</option>
                                                    <option value="+" @if(request()->query('action_ser') == '+') selected @endif>Addition</option>
                                                    <option value="-" @if(request()->query('action_ser') == '-') selected @endif>Subtraction</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route("product-adjustment.get")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                {{--<div class="col-md-12 text-right"></div>--}}
                            </div>

                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;

                                $site_unit_val = ($site_unit) ? $site_unit->value : 1;
                                $site_unit_name = ($site_unit) ? $site_unit->name : '';
                            ?>
                            <div class="card-body table-responsive" id="prin-table">
                                <span id="count_pan">Displaying adjustment from {{ ($adjustments->total()) ? $sl+1 : 0 }} to {{ $sl+$adjustments->count() }} out of total {{ $adjustments->total() }}</span>
                                <table class="table table-bordered production-table">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Date</th>
                                        <th>Reference</th>
                                        <th>Warehouse</th>
                                        <th>Action</th>
                                        <th>Product Name</th>
                                        <th>Unit</th>
                                        <th>Amount</th>
                                        <th>Quantity</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($adjustments as $adjustment)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ date("d/m/Y", strtotime($adjustment->adjustments_date)) }}</td>
                                            <td>{{ $adjustment->reference_no }}</td>
                                            <td>{{ $adjustment->warehouse_name }}</td>
                                            <td>
                                                {{ ($adjustment->action == '+') ? 'Addition' : 'Subtraction' }}
                                            </td>
                                            <td>{{ $adjustment->product_name }}</td>
                                            <td>{{ $adjustment->units_name }}</td>
                                            <td class="text-right">{{ number_format($adjustment->adjustments_amount, 2) }}</td>
                                            <td class="text-right">{{ number_format($adjustment->adjustments_qty/$adjustment->units_value, 2) }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="9" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse
                                        <tr>
                                            <td colspan="7" class="text-right"><b>Total</b></td>
                                            <td class="text-right"><b>{{number_format($total_price, 2)}}</b></td>
                                            <td class="text-right"><b>{{number_format($total_adjustment_qty/$site_unit_val, 2)}}&nbsp;{{$site_unit_name}}</b></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{ $adjustments->appends(\Request::except('page'))->links("backend.include.pagination") }}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

    <div id="purchase-details" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
        <div role="document" class="modal-dialog modal-lg">
            <div class="modal-content">
                {{--<div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{'Order In Details'}}</h5>
                    <button id="print-btn" type="button" class="btn btn-default btn-sm ml-3"><i class="fa fa-print"></i> {{'Print'}}</button>
                    <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>--}}

                <div class="container mt-3 pb-2 border-bottom">
                    <div class="row">
                        <div class="col-md-3">
                            <button id="print-btn" type="button" class="btn btn-default btn-sm d-print-none"><i class="fa fa-print"></i> Print</button>
                        </div>
                        <div class="col-md-6">
                            <h3 id="exampleModalLabel" class="modal-title text-center container-fluid">{{ $siteSetting->site_title ?? '' }}</h3>
                        </div>
                        <div class="col-md-3">
                            <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close d-print-none"><span aria-hidden="true">×</span></button>
                        </div>
                        <div class="col-md-12 text-center">
                            <i style="font-size: 15px;">Order In Details</i>
                        </div>
                    </div>
                </div>
                <div class="modal-body" id="product-edtils-body">

                </div>
            </div>
        </div>
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
