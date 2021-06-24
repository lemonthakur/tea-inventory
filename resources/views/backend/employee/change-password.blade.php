@extends("backend.master.main-layout")
@section("page-title","Employee Create")
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
                    <div class="col-md-6 offset-md-3">
                        <div class="card card-dark">
                            <div class="card-header">
                                <h3 class="card-title">Change Password</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("employee.change-password.store")}}">
                                @csrf
                                <div class="card-body">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="old_password">Old Password<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control {{$errors->has("old_password") ? "is-invalid":""}}" id="old_password" name="old_password" placeholder="Enter Old Password" value="{{old("old_password")}}">
                                                <span class="text-danger"> {{$errors->has("old_password") ? $errors->first("old_password") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="password">New Password<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control {{$errors->has("password") ? "is-invalid":""}}" id="password" name="password" placeholder="Enter User Password" value="{{old("password")}}">
                                                <span class="text-danger"> {{$errors->has("password") ? $errors->first("password") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="confirm_password">Confirm Password<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control {{$errors->has("confirm_password") ? "is-invalid":""}}" id="confirm_password" name="confirm_password" placeholder="Confirm User Password" value="{{old("confirm_password")}}">
                                                <span class="text-danger"> {{$errors->has("confirm_password") ? $errors->first("confirm_password") : ""}} </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card-body -->

                                <div class="card-footer text-right">
                                    <button type="submit" class="btn btn-dark">Submit</button>
                                    <a href="{{url()->previous()}}" class="btn btn-default cancel">Cancel</a>
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
