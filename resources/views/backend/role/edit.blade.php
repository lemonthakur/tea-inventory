@extends("backend.master.main-layout")
@section("page-title","Designation Edit")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Designation</h1>
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
                    <div class="col-md-6 offset-md-3">
                        <div class="card card-dark">
                            <div class="card-header">
                                <h3 class="card-title">Edit Designation</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("role.update",$role->id)}}">
                                @method('put')
                                @csrf
                                <div class="card-body">

                                    <div class="form-group">
                                        <label for="name">Name<span class="text-danger">*</span></label>
                                        <input type="text" required class="form-control {{$errors->has("name") ? "is-invalid":""}}" id="name" name="name" placeholder="Enter Role Name" value="{{old('name',$role->name)}}">
                                        <span class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                    </div>

                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" id="description" name="info" placeholder="Enter Role Description">{{old('description',$role->info)}}</textarea>
                                    </div>

                                    <div class="form-group select2-parent">
                                        <label>Status</label>
                                        <select name="status" class="form-control single-select2" style="width: 100%;" data-select2-id="1" tabindex="-1" aria-hidden="true">
                                            <option value="0" {{(old("status") == 0 || $role->status == 0 ) ? "selected" : "" }}>Inactive</option>
                                            <option value="1" {{(old("status") == 1 || $role->status == 1 ) ? "selected" : "" }}>Active</option>
                                        </select>
                                    </div>

                                </div>
                                <!-- /.card-body -->

                                <div class="card-footer text-right">
                                    <button type="submit" class="btn btn-dark">Submit</button>
                                    <button type="button" class="btn btn-default cancel">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection
