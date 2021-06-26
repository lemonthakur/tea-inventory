@extends("backend.master.main-layout")
@section("page-title","Supplier Create")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Supplier</h1>
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
                                <h3 class="card-title">Create Supplier</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("suppliers.store")}}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="name">Name<span class="text-red">*</span></label>
                                        <input type="text"
                                               class="form-control {{$errors->has("name") ? "is-invalid":""}}" id="name"
                                               name="name" required placeholder="Enter Supplier Name" value="{{old("name")}}">
                                        <span
                                            class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email<span class="text-red">*</span></label>
                                        <input type="email"
                                               class="form-control {{$errors->has("email") ? "is-invalid":""}}" id="email"
                                               name="email" required placeholder="Enter Supplier Email" value="{{old("email")}}">
                                        <span
                                            class="text-danger"> {{$errors->has("email") ? $errors->first("email") : ""}} </span>
                                    </div>
                                    <div class="form-group">
                                        <label for="contact_no">Contact NO.<span class="text-red">*</span></label>
                                        <input type="text"
                                               class="form-control {{$errors->has("contact_no") ? "is-invalid":""}}" id="contact_no"
                                               name="contact_no" required placeholder="Enter Supplier Contact Number" value="{{old("contact_no")}}">
                                        <span
                                            class="text-danger"> {{$errors->has("contact_no") ? $errors->first("contact_no") : ""}} </span>
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <textarea
                                               class="form-control {{$errors->has("address") ? "is-invalid":""}}" id="address"
                                               name="address" placeholder="Enter Supplier Address">{{old("address")}}</textarea>
                                        <span
                                            class="text-danger"> {{$errors->has("address") ? $errors->first("address") : ""}} </span>
                                    </div>
                                </div>
                                <!-- /.card-body -->

                                <div class="card-footer text-right">
                                    <button type="submit" class="btn btn-dark">Submit</button>
                                    <a href="{{ url()->previous() }}" class="btn btn-default cancel">Cancel</a>
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
