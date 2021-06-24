@extends("backend.master.main-layout")
@section("page-title","Unit")
@section("main-content")

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Unit</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <div class="card-body">
            <form method="get" action="{{route('unit.index')}}">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="q" name="q"
                                   value="{{request()->query('q')}}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group" style="padding-top: 33px;">
                            <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                            <a href="{{route("unit.index")}}" class="btn btn-danger " type="reset" id="reset_btn">Reset</a>
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
                                <h3 class="card-title">Unit List</h3>
                                @if(!empty($aclList[22][2]))
                                    <a href="{{route('unit.create')}}" class="btn btn-primary float-right text-white">
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
                                <span>Displaying unit from {{ ($units->total()) ? $sl+1 : 0 }} to {{ $sl+$units->count() }} out of total {{ $units->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Name</th>
                                        <th>Value in (grams)</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($units as $unit)
                                        <tr>
                                            <td>{{ ++$sl }}</td>
                                            <td>{{ $unit->name }}</td>
                                            <td class="text-right">{{ $unit->value }}</td>
                                            <td>{{ $unit->description }}</td>
                                            <td class="text-center">
                                                @if($unit->status == 1)
                                                    <button class="btn btn-xs btn-success">Active</button>
                                                @else
                                                    <button class="btn btn-xs btn-danger">Inactive</button>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                @if(!empty($aclList[22][3]) || !empty($aclList[22][4]))
                                                    @if(!empty($aclList[22][3]))
                                                        <a class="btn btn-xs btn-warning text-white" href="{{route('unit.edit',$unit->id)}}" title="Edit">
                                                            <i class="fas fa-pencil-alt"></i>
                                                        </a>
                                                    @endif
                                                @endif
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="7" class="text-center">Nothing Found</td>
                                        </tr>
                                    @endforelse

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{ $units->appends(\Request::except('page'))->links("backend.include.pagination") }}
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
