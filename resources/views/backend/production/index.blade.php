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

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Production List</h3>
                                <a href="{{route('production.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
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
                                        <th>Employee</th>
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
                                            <td>{{ucwords($production->employee->name)}}</td>
                                            <td class="text-center">
                                                @if($production->status == 1)
                                                    <label class="btn btn-xs btn-success">Finished</label>
                                                @else
                                                    <label class="btn btn-xs btn-warning">On going</label>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                @if(!empty($aclList[5][3]) || !empty($aclList[5][4]))
                                                    <a href="{{route('production.show',$production->id)}}" title="Details" class="btn btn-info btn-xs">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                @if($production->status == 0)
                                                    <a href="{{route('production.edit',$production->id)}}" title="Finished Production" class="btn btn-success btn-xs">
                                                        <i class="fas fa-check"></i>
                                                    </a>
                                                    @endif
                                                @endif
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="8" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{$productions->links("backend.include.pagination")}}
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
