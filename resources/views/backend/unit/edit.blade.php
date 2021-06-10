@extends("backend.master.main-layout")
@section("page-title","Unit-Update")
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
                                <h3 class="card-title">Update Unit</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("unit.update",$unit->id)}}" enctype="multipart/form-data">
                                @csrf
                                @method('put')
                                <div class="card-body">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="name">Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("name") ? "is-invalid":""}}"
                                                       id="name" name="name" placeholder="Enter name" value="{{old("name",$unit->name)}}" required>
                                                <span class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="name">Value in (grams)<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("value") ? "is-invalid":""}}"
                                                       id="value" name="value" placeholder="Enter name" value="{{old("value",$unit->value)}}" required>
                                                <span class="text-danger"> {{$errors->has("value") ? $errors->first("value") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="meta_description">Description</label>
                                                <textarea class="form-control {{$errors->has("description") ? "is-invalid":""}}" id="description" name="description"
                                                          placeholder="Enter description">{{old("description",$unit->description)}}</textarea>
                                                <span class="text-danger"> {{$errors->has("description") ? $errors->first("description") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group select2-parent">
                                                <label for="status">Status<span class="text-danger">*</span></label>
                                                <select name="status" class="form-control" id="status">
                                                    <option value="1" {{(old("status") == 1 || $unit->status == 1 ) ? "selected" : "" }}>Active</option>
                                                    <option value="2" {{(old("status") == 2 || $unit->status == 2 ) ? "selected" : "" }}>Inactive</option>
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
