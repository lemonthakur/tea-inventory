@extends("backend.master.main-layout")
@section("page-title","Order In List")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Order In</h1>
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

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Order In List</h3>
                                <a href="{{route('order.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <form method="get">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="name">Order No.</label>
                                                <input type="text" class="form-control" name="order_no"
                                                       value="{{request()->query('order_no')}}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="name">Search Barcode</label>
                                                <input type="text" class="form-control" name="barcode"
                                                       value="">
                                            </div>
                                        </div>

                                        <div class="col-md-1">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <a href="{{route("order.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
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
                            <div class="card-body table-responsive">
                                <span>Displaying Order from {{ ($purchases->total()) ? $sl+1 : 0 }} to {{ $sl+$purchases->count() }} out of total {{ $purchases->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Date</th>
                                        <th>Reference</th>
                                        <th>Supplier</th>
                                        <th class="text-center">Grand Total</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($purchases as $purchase)
                                        <tr class="purchase-link" data-purchase-id="{{ $purchase->id }}">
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ date("d/m/Y", strtotime($purchase->created_at)) }}</td>
                                            <td>{{ $purchase->reference_no }}</td>
                                            <td>{{ $purchase->supplier->name ?? '' }}</td>
                                            <td class="text-right">{{ number_format($purchase->grand_total, 2) }}</td>
                                            <td class="text-center">
                                                @if($purchase->status == 1)
                                                    <button class="btn btn-xs btn-success">Received</button>
                                                @else
                                                    <button class="btn btn-xs btn-warning">Pending</button>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action
                                                        <span class="caret"></span>
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                                        @if($purchase->status == 1)
                                                            <li>
                                                                <a type="button" class="btn btn-link" href="{{route('order.label', $purchase->id)}}" target="_blank">
                                                                    <i class="fa fa-check"></i> Print Label</a>
                                                            </li>
                                                        @endif
                                                        @if($purchase->status == 2)
                                                            <li>
                                                                <button type="button" class="btn btn-link received" data-purchase-id="{{ $purchase->id }}" data-link="{{route('order.received', $purchase->id)}}">
                                                                    <i class="fa fa-check"></i> Mark as received</button>
                                                            </li>
                                                        @endif
                                                        <li>
                                                            <button type="button" class="btn btn-link view" data-purchase-id="{{ $purchase->id }}"><i class="fa fa-eye"></i> View
                                                            </button>
                                                        </li>
                                                        <li>
                                                            <a class="btn btn-link" href="{{route('order.edit',$purchase->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i> Edit
                                                            </a>
                                                        </li>
                                                        <form method="post" action="{{ route('order.destroy',$purchase->id) }}">
                                                            @method('delete')
                                                            @csrf
                                                            <li>
                                                                <button type="submit" class="btn btn-link delete" title="Delete">
                                                                    <i class="fas fa-trash-alt text-danger"></i> Delete
                                                                </button>
                                                            </li>
                                                        </form>
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
                                {{$purchases->links("backend.include.pagination")}}
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
            $(document).on("click", "tr.purchase-link", function() {
                var purchase_id = $(this).data('purchase-id');
                purchaseDetails( purchase_id );
            });

            $(document).on("click", ".view", function(){
                var purchase_id = $(this).data('purchase-id');
                purchaseDetails(purchase_id);
            });

            var _token = "{{ csrf_token() }}";
            function purchaseDetails(purchase_id) {
                $('#product-edtils-body').html("");
                if(purchase_id){
                    $.ajax({
                        type: "POST",
                        url: "{!! route('order-details.get') !!}",
                        data: {purchase_id: purchase_id, _token: _token},
                        //dataType : 'HTML',
                        success: function (result) {
                            $('#product-edtils-body').html(result);
                        },
                        complete: function (e) {
                            $('#purchase-details').modal('show');
                        }
                    });

                }
            }

            // Received status change
            $('.received').on('click', function (e) {
                var purchase_id = $(this).data('purchase-id');
                const url = $(this).data('link');;
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    type: 'warning',
                    cancelButtonColor: '#d33',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    showCancelButton: true,
                }).then((result) => {
                    if (result.value) {
                        window.location.href = url;
                    }
                });
            });

            $("#print-btn").on("click", function(){
                var divToPrint=document.getElementById('purchase-details');
                var newWin=window.open('','Print-Window');
                newWin.document.open();
                newWin.document.write('<link rel="stylesheet" href="<?php echo asset('public/admin-lte/dist/css/adminlte.min.css') ?>" type="text/css"><style type="text/css">@media print {.modal-dialog { max-width: 1000px;} #print-btn, #close-btn {visibility: hidden;} }</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
