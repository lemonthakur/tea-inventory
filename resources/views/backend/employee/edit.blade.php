@extends("backend.master.main-layout")
@section("page-title","Employee Edit")
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
                    <div class="col-md-8 offset-md-2">
                        <div class="card card-dark">
                            <div class="card-header">
                                <h3 class="card-title">Edit Employee</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("employees.update",$employee->id)}}" enctype="multipart/form-data">
                                @csrf
                                @method('put')
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="name">Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("name") ? "is-invalid":""}}" id="name" name="name" placeholder="Enter User Name" value="{{old("name",$employee->name)}}">
                                                <span class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Email<span class="text-danger">*</span></label>
                                                <input type="email" class="form-control {{$errors->has("email") ? "is-invalid":""}}" id="email" name="email" placeholder="Enter User Email" value="{{old("email",$employee->email)}}">
                                                <span class="text-danger"> {{$errors->has("email") ? $errors->first("email") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="contact_no">Contact No<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("contact_no") ? "is-invalid":""}}" id="contact_no" name="contact_no" placeholder="Enter User Contact No" value="{{old("contact_no",$employee->contact_no)}}">
                                                <span class="text-danger"> {{$errors->has("contact_no") ? $errors->first("contact_no") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group select2-parent">
                                                <label for="role_id">Designation<span class="text-danger">*</span></label>
                                                <select name="role_id" class="form-control single-select2" id="role_id" style="width: 100%;"
                                                        data-placeholder="Select Designation">
                                                    <option></option>
                                                    @foreach($roles as $role)
                                                        <option value="{{ $role->id }}" {{($employee->role_id == $role->id) ? 'selected' : ''}}>{{$role->name}}</option>
                                                    @endforeach
                                                </select>
                                                <span class="text-danger"> {{$errors->has("role_id") ? $errors->first("role_id") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6 d-none">
                                            <div class="form-group">
                                                <label for="designation">Designation<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("designation") ? "is-invalid":""}}" id="designation" name="designation" placeholder="Enter Employee Designation" value="{{old("designation",$employee->designation)}}">
                                                <span class="text-danger"> {{$errors->has("designation") ? $errors->first("designation") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group select2-parent">
                                                <label for="warehouse">Warehouse</label>
                                                <select
                                                    class="form-control single-select2 {{$errors->has("warehouse_id") ? "is-invalid":""}}"
                                                    data-placeholder="Select Warehouse" data-allow-clear="true"
                                                    id="warehouse" name="warehouse_id[]" multiple>
                                                    <option></option>
                                                    @foreach($warehouses as $warehouse)
                                                        <option {{ in_array($warehouse->id,old('warehouse_id',$employeeWarehouses)) ? 'selected' : ''}} value="{{$warehouse->id}}">{{ucwords($warehouse->name)}}</option>
                                                    @endforeach
                                                </select>

                                                <span
                                                    class="text-danger"> {{$errors->has("warehouse_id") ? $errors->first("warehouse_id") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="password">Password<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control {{$errors->has("password") ? "is-invalid":""}}" id="password" name="password" placeholder="Enter User Password" value="{{old("password")}}">
                                                <span class="text-danger"> {{$errors->has("password") ? $errors->first("password") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="confirm_password">Confirm Password<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control {{$errors->has("confirm_password") ? "is-invalid":""}}" id="confirm_password" name="confirm_password" placeholder="Confirm User Password" value="{{old("confirm_password")}}">
                                                <span class="text-danger"> {{$errors->has("confirm_password") ? $errors->first("confirm_password") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group select2-parent">
                                                <label>Status</label>
                                                <select name="status" class="form-control single-select2" style="width: 100%;" data-select2-id="1" tabindex="-1" aria-hidden="true">
                                                    <option value="0" {{(old("status") == 0 || $employee->status == 0 ) ? "selected" : "" }}>Inactive</option>
                                                    <option value="1" {{(old("status") == 1 || $employee->status == 1 ) ? "selected" : "" }}>Active</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label>
                                                Upload Profile Image
                                            </label>
                                            <p><input name="photo" type="file"  accept="image/*" class="image" id="image" style="display: none;"></p>
                                            <p><label for="image" style="cursor: pointer;">
                                                    @if($employee->photo)
                                                        <img id="output" src="{{asset($employee->photo)}}" width="200"/>
                                                        @else
                                                        <img id="output" src="{{asset('/public/demo-pic/upload-image.jpg')}}" width="200"/>
                                                        @endif

                                                </label></p>
                                            <span class="text-danger"> {{$errors->has("photo") ? $errors->first("photo") : ""}} </span>
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
