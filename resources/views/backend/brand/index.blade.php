@extends("backend.master.main-layout")
@section("page-title","Brand")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Brand</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
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
                                <h3 class="card-title">Brand List</h3>
                                @if(!empty($aclList[19][2]))
                                    <a href="{{route('brand.create')}}" class="btn btn-primary float-right text-white">
                                        <i class="fas fa-plus-circle"></i>
                                        Add New
                                    </a>
                                @endif
                            </div>
                            <div class="card-body">
                                <form method="get" action="{{route('brand.index')}}">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="name">Name/Email/Contact Number</label>
                                                <input type="text" class="form-control" id="q" name="q"
                                                       value="{{request()->query('q')}}">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route("brand.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- /.card-header -->
                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive">
                                <span>Displaying brand from {{ ($brands->total()) ? $sl+1 : 0 }} to {{ $sl+$brands->count() }} out of total {{ $brands->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Representative</th>
                                        <th>Address</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($brands as $brand)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ $brand->name }}</td>
                                            <td>{{ $brand->brand_email }}</td>
                                            <td>{{ $brand->brand_mobile }}</td>
                                            <td>{{ $brand->brand_representatives_name }}</td>
                                            <td>{{ $brand->address }}</td>
                                            <td class="text-center">
                                                @if($brand->status == 1)
                                                    <button class="btn btn-xs btn-success">Active</button>
                                                @else
                                                    <button class="btn btn-xs btn-danger">Inactive</button>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                @if(!empty($aclList[19][3]) || !empty($aclList[19][4]))
                                                    <form method="post" action="{{ route('brand.destroy',$brand->id) }}">
                                                        @if(!empty($aclList[19][3]))
                                                            <a class="btn btn-xs btn-warning text-white" href="{{route('brand.edit',$brand->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i>
                                                            </a>
                                                        @endif
                                                        @if(!empty($aclList[19][4]))
                                                            @method('delete')
                                                            @csrf
                                                            {{--<button type="submit" class="btn btn-xs btn-danger text-white delete" title="Delete">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>--}}
                                                            @if($brand->status == 1)
                                                                <button type="submit" class="btn btn-xs btn-danger text-white delete" title="Inactive">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            @else
                                                                <button type="submit" class="btn btn-xs btn-success text-white delete" title="Active">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            @endif
                                                        @endif
                                                    </form>
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
                                {{ $brands->appends(\Request::except('page'))->links("backend.include.pagination") }}
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

        })
    </script>
@endsection
