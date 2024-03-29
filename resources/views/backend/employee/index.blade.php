@extends("backend.master.main-layout")
@section("page-title","Employee List")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Employee</h1>
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
                                <h3 class="card-title">Employee List</h3>
                                @if(!empty($aclList[10][2]))
                                <a href="{{route('employees.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
                                    @endif
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <form method="get">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="name">Name/email/phone</label>
                                                <input type="text" class="form-control" name="name_ser" value="{{request()->query('name_ser')}}">
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group" style="padding-top: 33px;">
                                                <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                                <a href="{{route('employees.index')}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead>
                                        <tr>
                                            <th>SL</th>
                                            <th>Photo</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Contact No</th>
                                            <th>Designation</th>
                                            <th>Created By</th>
                                            <th>Updated By</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @forelse($users as $user)
                                            <tr>
                                                <td>{{$loop->iteration}}</td>
                                                <td>
                                                    @if($user->photo)
                                                        <img src="{{asset($user->photo)}}" width="80px">
                                                    @endif
                                                </td>
                                                <td>{{ $user->name }}</td>
                                                <td>{{ $user->email }}</td>
                                                <td>{{$user->contact_no}}</td>
                                                <td>{{$user->role->name ?? ''}}</td>
                                                <td>{{$user->creator->name ?? ''}}</td>
                                                <td>{{$user->updator->name ?? ''}}</td>
                                                <td class="text-center">
                                                    @if($user->status == 1)
                                                        <button class="btn btn-xs btn-success">Active</button>
                                                    @else
                                                        <button class="btn btn-xs btn-danger">Inactive</button>
                                                    @endif
                                                </td>
                                                <td class="text-center">

                                                    <form method="post" action="{{ route('employees.destroy',$user->id) }}">
                                                        @if(!empty($aclList[10][3]))
                                                        <a class="btn btn-xs btn-warning text-white" href="{{route('employees.edit',$user->id)}}" title="Edit">
                                                            <i class="fas fa-pencil-alt"></i>
                                                        </a>
                                                        @endif
                                                        @method('delete')
                                                        @csrf
                                                            {{--@if(!empty($aclList[10][4]))
                                                        <button type="submit" class="btn btn-xs btn-danger text-white delete" title="Delete">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                                @endif--}}
                                                        @if(!empty($aclList[10][4]))
                                                            @if($user->status == 1)
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
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{$users->links("backend.include.pagination")}}
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
    <script>
        $('#live-search').select2({
            ajax: {
                url: "{{route('employee.get')}}",
                type:"POST",
                dataType:"JSON",
                data: function (params) {
                    return  query = {
                        search: params.term,
                        _token: "{{csrf_token()}}"
                    }
                },

                processResults: function (response) {
                    return {
                        results: response
                    };
                },
            },
            placeholder: 'Search by employee name',
            minimumInputLength: 2,
        });
    </script>
@endsection
