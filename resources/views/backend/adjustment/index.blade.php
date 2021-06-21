@extends("backend.master.main-layout")
@section("page-title","Adjustment List")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Adjustment</h1>
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
                                <h3 class="card-title">Adjustment List</h3>
                                @if(!empty($aclList[13][2]))
                                <a href="{{route('qty_adjustment.create')}}" class="btn btn-primary float-right text-white">
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
                                <span>Displaying adjustment from {{ ($adjustments->total()) ? $sl+1 : 0 }} to {{ $sl+$adjustments->count() }} out of total {{ $adjustments->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Date</th>
                                        <th>Reference</th>
                                        <th>Warehouse</th>
                                        <th>Products</th>
                                        <th>Note</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($adjustments as $adjustment)
                                        <tr class="transfer-link" data-transfer-id="{{ $adjustment->id }}">
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ date("d/m/Y", strtotime($adjustment->created_at)) }}</td>
                                            <td>{{ $adjustment->reference_no }}</td>
                                            <td>{{ $adjustment->warehouse->name ?? '' }}</td>
                                            <td>
                                                @if($adjustment->adjustment_projectst)
                                                    @foreach($adjustment->adjustment_projectst as $p)
                                                        {{$p->product->name}} [{{ $p->product->code }}] {{"Qty: ".$p->qty}}<br>
                                                    @endforeach
                                                @endif
                                            </td>
                                            <td>{{ $adjustment->note }}</td>
                                            <td class="text-center">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action
                                                        <span class="caret"></span>
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                                        @if(!empty($aclList[13][3]))
                                                        <li>
                                                            <a class="btn btn-link" href="{{route('qty_adjustment.edit',$adjustment->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i> Edit
                                                            </a>
                                                        </li>
                                                        @endif
                                                            @if(!empty($aclList[13][4]))
                                                        <form method="post" action="{{ route('qty_adjustment.destroy',$adjustment->id) }}">
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
                                {{$adjustments->links("backend.include.pagination")}}
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

        });
    </script>
@endsection
