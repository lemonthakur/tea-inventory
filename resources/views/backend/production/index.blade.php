@extends("backend.master.main-layout")
@section("page-title","Production")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Production</h1>
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
                            <label for="name">Ser Barcode/Pro. Num.</label>
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
                        <div class="form-group" {{--style="padding-top: 33px;"--}}>
                            <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                            <a href="{{route("production.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                        </div>
                    </div>
                </div>
            </form>
            {{--<div class="col-md-12 text-right"></div>--}}
        </div>

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Production List</h3>
                                @if(!empty($aclList[18][2]))
                                <a href="{{route('production.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
                                    @endif
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body table-responsive">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Production Number</th>
                                        <th>Warehouse</th>
                                        <th>Product Name</th>
                                        <th>Target Amount</th>
                                        <th>Produce Amount</th>
                                        <th>Waste Amount</th>
                                        <th>Unit</th>
                                        <th>Employee</th>
                                        <th>Start At</th>
                                        <th>End At</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($productions as $production)
                                        <tr>
                                            <td>{{$loop->iteration}}</td>
                                            <td>{{ ucwords($production->production_number) }}</td>
                                            <td>{{ $production->warehouse->name ?? '' }}</td>
                                            <td>{{$production->product->name}}</td>
                                            <td>{{$production->targate_amount ?? ''}}</td>
                                            <td>{{$production->produce_amount ?? ''}}</td>
                                            <td>{{$production->waste_amount ?? ''}}</td>
                                            <td>{{$production->unit_name ?? ''}}</td>
                                            <td>{{ucwords($production->employee->name)}}</td>
                                            <td>{{date('d M, Y',strtotime($production->created_at))}}</td>
                                            <td>
                                                @if($production->status == 1)
                                                    {{date('d M, Y',strtotime($production->updated_at))}}
                                                    @endif
                                            </td>
                                            <td class="text-center">
                                                @if($production->status == 1)
                                                    <label class="btn btn-xs btn-success">Finished</label>
                                                @else
                                                    <label class="btn btn-xs btn-warning">On going</label>
                                                @endif
                                            </td>
                                            <td class="text-center">

                                                @if(!empty($aclList[18][8]))
                                                    <a href="{{route('production.show',$production->id)}}" title="Details" class="btn btn-info btn-xs" target="_blank">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                @endif
                                                    @if(!empty($aclList[18][3]))
                                                @if($production->status == 0)
                                                    <a href="{{route('production.edit',$production->id)}}" title="Finished Production" class="btn btn-warning btn-xs">
                                                        <i class="fas fa-pencil-alt"></i>
                                                    </a>
                                                    @endif
                                                        @endif
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
                                {{ $productions->appends(\Request::except('page'))->links("backend.include.pagination") }}
                                {{--{{$productions->links("backend.include.pagination")}}--}}
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
