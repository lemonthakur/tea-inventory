@extends("backend.master.main-layout")
@section("page-title","Category List")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Category</h1>
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
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" name="name_ser"
                                   value="{{request()->query('name_ser')}}">
                        </div>
                    </div>

                    <div class="col-md-2">
                        <div class="form-group" style="padding-top: 33px;">
                            <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                            <a href="{{route("categories.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
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
                                <h3 class="card-title">Category List</h3>
                                @if(!empty($aclList[11][2]))
                                <a href="{{route('categories.create')}}" class="btn btn-primary float-right text-white">
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
                                        <th>Name</th>
                                        <th>Parent Category</th>
                                        <th>Created By</th>
                                        <th>Updated By</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($categories as $category)
                                        <tr>
                                            <td>{{$paginate++}}</td>
                                            <td>{{ $category->name }}</td>
                                            <td>{{ $category->category->name ?? '' }}</td>
                                            <td>{{$category->createdBy->name ?? ''}}</td>
                                            <td>{{ $category->updatedBy->name ?? '' }}</td>
                                            <td class="text-center">
                                                @if($category->status == 1)
                                                    <button class="btn btn-xs btn-success">Active</button>
                                                @else
                                                    <button class="btn btn-xs btn-danger">Inactive</button>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                    <form method="post" action="{{ route('categories.destroy',$category->id) }}">
                                                        @if(!empty($aclList[11][3]))
                                                            <a class="btn btn-xs btn-warning text-white" href="{{route('categories.edit',$category->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i>
                                                            </a>
                                                        @endif
                                                            @if(!empty($aclList[11][4]))
                                                            @method('delete')
                                                            @csrf
                                                            <button type="submit" class="btn btn-xs btn-danger text-white delete" title="Delete">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                                @endif
                                                    </form>
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
                                {{$categories->links("backend.include.pagination")}}
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
