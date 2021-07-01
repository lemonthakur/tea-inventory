@extends("backend.master.main-layout")
@section("page-title","Production Report")
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
                                <h3 class="card-title" style="margin-left: 45% !important;">Production Report</h3>
                                <p style="margin-left: 95% !important;">
                                    @if(!empty($aclList[27][7]))
                                        <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                                    @endif
                                    @if(!empty($aclList[27][9]))
                                        <a href="{{route('production-report.excel').'?'.http_build_query(request()->query())}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                                    @endif
                                </p>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                @csrf
                                <form method="get" action="{{route('production-report.get')}}">
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
                                                <label for="name">Ser. Barcode/Pro. Num.</label>
                                                <input type="text" class="form-control" name="barcode"
                                                       value="">
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
                                                <label for="warehouse">Employee</label>
                                                <select
                                                        class="form-control single-select2"
                                                        data-placeholder="Select employee" data-allow-clear="true"
                                                        id="employee_ser" name="employee_ser">
                                                    <option></option>
                                                    @foreach($users as $user)
                                                        <option value="{{$user->id}}" @if(request()->query('employee_ser') == $user->id) selected @endif>{{ucwords($user->name)}}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="production_start_from">Production Start From</label>
                                                <input type="text" class="form-control datepicker" id="production_start_from" name="production_start_from" value="{{request()->query('production_start_from')}}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="production_start_to">Production Start to</label>
                                                <input type="text" class="form-control datepicker" id="production_start_to" name="production_start_to" value="{{request()->query('production_start_to')}}" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="production_finished_from">Production Finished From</label>
                                                <input type="text" class="form-control datepicker" id="production_finished_from" name="production_finished_from" value="{{request()->query('production_finished_from')}}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="production_finished_to">Production Finished to</label>
                                                <input type="text" class="form-control datepicker" id="production_finished_to" name="production_finished_to" value="{{request()->query('production_finished_to')}}" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group select2-parent">
                                                <label for="warehouse">Status</label>
                                                <select
                                                    class="form-control" data-allow-clear="true"
                                                    id="status" name="status">
                                                    <option selected disabled>Select status</option>
                                                    <option  @if(request()->query('status') == '1') selected @endif value="1">Ongoing</option>
                                                    <option  @if(request()->query('status') == '2') selected @endif value="2">Finished</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group text-right" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route("production-report.get")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <div class="col-md-12 text-right">
{{--                                    <a href="{{route('low-quantity.print').'?'.http_build_query(request()->query())}}" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></a>--}}
{{--                                    @if(!empty($aclList[27][7]))--}}
{{--                                    <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>--}}
{{--                                    @endif--}}
{{--                                    @if(!empty($aclList[27][9]))--}}
{{--                                        <a href="{{route('production-report.excel').'?'.http_build_query(request()->query())}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>--}}
{{--                                    @endif--}}
                                </div>

                            </div>

                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive" id="prin-table">
                                <span id="count_pan">Displaying Order from {{ ($productions->total()) ? $sl+1 : 0 }} to {{ $sl+$productions->count() }} out of total {{ $productions->total() }}</span>
                                <table class="table table-bordered production-table">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Production Number</th>
                                        <th>Warehouse</th>
                                        <th>Product Name</th>
                                        <th>Produce</th>
                                        <th>Waste</th>
                                        <th>Unit</th>
                                        <th>Employee</th>
                                        <th>Start At</th>
                                        <th>End At</th>
                                        <th>Status</th>
                                        <th class="action">Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($productions as $production)
                                        <tr>
                                            <td>{{++$sl}}</td>
                                            <td>{{ ucwords($production->production_number) }}</td>
                                            <td>{{ $production->warehouse_name ?? '' }}</td>
                                            <td>{{$production->product_name}}</td>
                                            <td>{{$production->produce_amount ?? ''}}</td>
                                            <td>{{$production->waste_amount ?? ''}}</td>
                                            <td>{{$production->unit_name ?? ''}}</td>
                                            <td>{{ucwords($production->employee_name)}}</td>
                                            <td>{{date('d-m-Y',strtotime($production->start_at))}}</td>
                                            <td>
                                                @if($production->status == 1)
                                                    {{date('d-m-Y',strtotime($production->end_at))}}
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                @if($production->status == 1)
                                                    <label class="btn btn-xs btn-success">Finished</label>
                                                @else
                                                    <label class="btn btn-xs btn-warning">On going</label>
                                                @endif
                                            </td>
                                            <td class="text-center action">

                                                @if(!empty($aclList[18][8]))
                                                    <a href="{{route('production.show',$production->production_id)}}" title="Details" class="btn btn-info btn-xs">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                @endif
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="12" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{ $productions->appends(\Request::except('page'))->links("backend.include.pagination") }}
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
                    ' table td.action, table th.action {visibility: hidden}' +
                    ' #count_pan {visibility: hidden}' +
                    ' .text-center {text-align: center !important}' +
                    ' .text-right {text-align: right !important}' +
                    '</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
