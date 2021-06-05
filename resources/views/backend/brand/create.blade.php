@extends("backend.master.main-layout")
@section("page-title","Brand-Create")
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
                                <h3 class="card-title">Create Brand</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("brand.store")}}" enctype="multipart/form-data">
                                @csrf
                                <div class="card-body">
                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="name">Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("name") ? "is-invalid":""}}"
                                                       id="name" name="name" placeholder="Enter name" value="{{old("name")}}" required>
                                                <span class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="brand_representatives_name">Representatives Name</label>
                                                <input type="text" class="form-control {{$errors->has("brand_representatives_name") ? "is-invalid":""}}" id="brand_representatives_name"
                                                       name="brand_representatives_name" placeholder="Enter representatives name" value="{{old("brand_representatives_name")}}">
                                                <span class="text-danger"> {{$errors->has("brand_representatives_name") ? $errors->first("brand_representatives_name") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="brand_email">Email</label>
                                                <input type="email" class="form-control {{$errors->has("brand_email") ? "is-invalid":""}}"
                                                       id="brand_email" name="brand_email" placeholder="Enter email" value="{{old("brand_email")}}">
                                                <span class="text-danger"> {{$errors->has("brand_email") ? $errors->first("brand_email") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Mobile</label>
                                                <input type="text" class="form-control {{$errors->has("brand_mobile") ? "is-invalid":""}}" id="brand_mobile"
                                                       name="brand_mobile" placeholder="Enter mobile number" value="{{old("brand_mobile")}}">
                                                <span class="text-danger"> {{$errors->has("brand_mobile") ? $errors->first("brand_mobile") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="meta_description">Address</label>
                                                <textarea class="form-control {{$errors->has("address") ? "is-invalid":""}}" id="address" name="address"
                                                          placeholder="Enter address">{{old("address")}}</textarea>
                                                <span class="text-danger"> {{$errors->has("address") ? $errors->first("address") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="meta_description">Short Description</label>
                                                <textarea class="form-control {{$errors->has("description") ? "is-invalid":""}}" id="description" name="description"
                                                          placeholder="Enter description">{{old("description")}}</textarea>
                                                <span class="text-danger"> {{$errors->has("description") ? $errors->first("description") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label>
                                                Select Logo
                                            </label>
                                            <p><input type="file"  accept="image/*" name="brand_thumbnail" class="image" id="image" style="display: none;"></p>
                                            <p>
                                                <label for="image" style="cursor: pointer;">
                                                    <img id="output" src="{{asset('/public/demo-pic/upload-image.jpg')}}" width="180"/>
                                                </label>
                                            </p>
                                            <span class="text-danger"> {{$errors->has("brand_thumbnail") ? $errors->first("brand_thumbnail") : ""}} </span>
                                        </div>

                                        <div class="col-md-6">
                                            <label>
                                                Select Banner
                                            </label>
                                            <p><input type="file"  accept="image/*" name="brand_banner" class="logo" id="logo" style="display: none;"></p>
                                            <p><label for="logo" style="cursor: pointer;">
                                                   <img id="outputLogo" src="{{asset('/public/demo-pic/upload-image.jpg')}}" width="180"/>
                                                </label></p>
                                            <span class="text-danger"> {{$errors->has("brand_banner") ? $errors->first("brand_banner") : ""}} </span>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group select2-parent">
                                                <label for="status">Status<span class="text-danger">*</span></label>
                                                <select name="status" class="form-control" id="status">
                                                    <option value="1">Active</option>
                                                    <option value="2">Inactive</option>
                                                </select>
                                                <span class="text-danger"> {{$errors->has("status") ? $errors->first("status") : ""}} </span>
                                            </div>
                                        </div>

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

@section('js')
    <script src="{{asset("/public/admin-lte/plugins/bs-custom-file-input/bs-custom-file-input.min.js")}}"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            bsCustomFileInput.init();
        })
    </script>
@endsection

