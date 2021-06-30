@extends("backend.master.main-layout")
@section("page-title","Transfer List")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Transfer</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            {{--<li class="breadcrumb-item"><a href="#">Home</a></li>--}}
                            {{--<li class="breadcrumb-item active">Starter Page</li>--}}
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <div class="card-body">
            <form method="get">
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
                        <div class="form-group">
                            <label for="name">Start Date</label>
                            <input type="text" class="form-control datepicker" id="start_date" name="start_date" value="{{request()->query('start_date')}}" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="name">End Date</label>
                            <input type="text" class="form-control datepicker" id="end_date" name="end_date" value="{{request()->query('end_date')}}" readonly>
                        </div>
                    </div>

                    <div class="col-md-2">
                        <div class="form-group" style="padding-top: 33px;">
                            <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                            <a href="{{route("transfer.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Transfer List</h3>
                                @if(!empty($aclList[16][2]))
                                <a href="{{route('transfer.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
                                    @endif
                            </div>
                            <!-- /.card-header -->
                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive">
                                <span>Displaying transfer from {{ ($transfers->total()) ? $sl+1 : 0 }} to {{ $sl+$transfers->count() }} out of total {{ $transfers->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Date</th>
                                        <th>Reference</th>
                                        <th>Warehouse(From)</th>
                                        <th>Warehouse(To)</th>
                                        <th class="text-center">Grand Total</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($transfers as $transfer)
                                        <tr class="transfer-link" data-transfer-id="{{ $transfer->id }}">
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ date("d/m/Y", strtotime($transfer->created_at)) }}</td>
                                            <td>{{ $transfer->reference_no }}</td>
                                            <td>{{ $transfer->fromWarehouse->name ?? '' }}</td>
                                            <td>{{ $transfer->toWarehouse->name ?? '' }}</td>
                                            <td class="text-right">{{ number_format($transfer->grand_total, 2) }}</td>
                                            <td class="text-center">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action
                                                        <span class="caret"></span>
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                                        @if(!empty($aclList[16][8]))
                                                        <li>
                                                            <button type="button" class="btn btn-link view" data-transfer-id="{{ $transfer->id }}"><i class="fa fa-eye"></i> View
                                                            </button>
                                                        </li>
                                                        @endif
                                                            @if(!empty($aclList[16][3]))
                                                        <li>
                                                            <a class="btn btn-link" href="{{route('transfer.edit',$transfer->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i> Edit
                                                            </a>
                                                        </li>
                                                            @endif
                                                            @if(!empty($aclList[16][4]))
                                                        <form method="post" action="{{ route('transfer.destroy',$transfer->id) }}">
                                                            @method('delete')
                                                            @csrf
                                                            <li>
                                                                <button type="submit" class="btn btn-link delete" title="Delete">
                                                                    <i class="fas fa-trash-alt text-danger"></i> Delete
                                                                </button>
                                                            </li>
                                                        </form>
                                                                @endif
                                                    </ul>
                                                </div>

                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="10" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{ $transfers->appends(\Request::except('page'))->links("backend.include.pagination") }}
                                {{--{{$transfers->links("backend.include.pagination")}}--}}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

    <div id="transfer-details" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
        <div role="document" class="modal-dialog modal-lg">
            <div class="modal-content">
                {{--<div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{'Transfer Details'}}</h5>
                    <button id="print-btn" type="button" class="btn btn-default btn-sm ml-3"><i class="fa fa-print"></i> {{'Print'}}</button>
                    <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>--}}

                <div class="container mt-3 pb-2 border-bottom">
                    <div class="row">
                        <div class="col-md-3">
                            @if(!empty($aclList[16][7]))
                            <button id="print-btn" type="button" class="btn btn-default btn-sm d-print-none"><i class="fa fa-print"></i> Print</button>
                            @endif
                        </div>
                        <div class="col-md-6">
                            <h3 id="exampleModalLabel" class="modal-title text-center container-fluid">{{ $siteSetting->site_title ?? '' }}</h3>
                        </div>
                        <div class="col-md-3">
                            <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close d-print-none"><span aria-hidden="true">×</span></button>
                        </div>
                        <div class="col-md-12 text-center">
                            <i style="font-size: 15px;">Transfer Details</i>
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
            $(document).on("click", "tr.transfer-link", function() {
                var transfer_id = $(this).data('transfer-id');
                transferDetails( transfer_id );
            });

            $(document).on("click", ".view", function(){
                var transfer_id = $(this).data('transfer-id');
                transferDetails(transfer_id);
            });

            var _token = "{{ csrf_token() }}";
            function transferDetails(transfer_id) {
                $('#product-edtils-body').html("");
                if(transfer_id){
                    $.ajax({
                        type: "POST",
                        url: "{!! route('transfer-details.get') !!}",
                        data: {transfer_id: transfer_id, _token: _token},
                        //dataType : 'HTML',
                        success: function (result) {
                            $('#product-edtils-body').html(result);
                        },
                        complete: function (e) {
                            $('#transfer-details').modal('show');
                        }
                    });

                }
            }

            $("#print-btn").on("click", function(){
                var divToPrint=document.getElementById('transfer-details');
                var newWin=window.open('','Print-Window');
                newWin.document.open();
                newWin.document.write('<link rel="stylesheet" href="<?php echo asset('public/admin-lte/dist/css/adminlte.min.css') ?>" type="text/css"><style type="text/css">@media print {.modal-dialog { max-width: 1000px;} #print-btn, #close-btn {visibility: hidden;} }</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
