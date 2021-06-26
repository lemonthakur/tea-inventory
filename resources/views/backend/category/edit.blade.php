@extends("backend.master.main-layout")
@section("page-title","Category Edit")
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

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card card-dark">
                            <div class="card-header">
                                <h3 class="card-title">Edit Category</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("categories.update",$category->id)}}">
                                @method('put')
                                @csrf
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label for="name">Name<span class="text-red">*</span></label>
                                            <input type="text"
                                                   class="form-control {{$errors->has("name") ? "is-invalid":""}}" id="name"
                                                   name="name" required placeholder="Enter Category Name" value="{{old("name",ucwords($category->name))}}">
                                            <span
                                                class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                        </div>
                                        <div class="form-group select2-parent">
                                            <label for="category_id">Parent Category</label>
                                            <select type="text"
                                                    class="form-control single-select2 {{$errors->has("category_id") ? "is-invalid":""}}"
                                                    data-placeholder="Select parent category" data-allow-clear="true"
                                                    id="category_id" name="category_id">
                                                <option></option>
                                                @foreach($categories as $cat)
                                                    @if($cat->id != $category->id)
                                                        <option {{(old('category_id',$category->category_id) == $cat->id) ? 'selected' : ''}} value="{{$cat->id}}">{{ucwords($cat->name)}}</option>
                                                    @endif
                                                @endforeach
                                            </select>
                                            <span
                                                class="text-danger"> {{$errors->has("category_id") ? $errors->first("category_id") : ""}} </span>
                                        </div>
                                        <div class="form-group select2-parent">
                                            <label>Status</label>
                                            <select name="status" class="form-control single-select2" style="width: 100%;" data-select2-id="1" tabindex="-1" aria-hidden="true">
                                                <option value="0" {{(old("status",$category->status) == 0) ? "selected" : "" }}>Inactive</option>
                                                <option value="1" {{(old("status",$category->status) == 1) ? "selected" : "" }}>Active</option>
                                            </select>
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
