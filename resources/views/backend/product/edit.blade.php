@extends("backend.master.main-layout")
@section("page-title","Product Edit")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Product</h1>
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
                        <div class="card card-dark">
                            <div class="card-header">
                                <h3 class="card-title">Edit Product</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form method="post" action="{{route("product.update",$product->id)}}" enctype="multipart/form-data">
                                @csrf
                                @method('put')
                                <div class="card-body">
                                    <div class="row">


                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="name">Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control {{$errors->has("name") ? "is-invalid":""}}" id="name"
                                                       name="name" placeholder="Enter User Name" value="{{old("name", $product->name)}}" required>
                                                <span class="text-danger"> {{$errors->has("name") ? $errors->first("name") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Product Code<span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="text" name="code" class="form-control {{$errors->has("code") ? "is-invalid":""}}"
                                                           id="code" value="{{old("code", $product->code)}}" aria-describedby="code" required>
                                                    <div class="input-group-append">
                                                        <button id="genbutton" type="button" class="btn btn-sm btn-default" title="Generate"><i class="fas fa-sync"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                            <span class="text-danger"> {{$errors->has("code") ? $errors->first("code") : ""}} </span>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Barcode Symbology <span class="text-danger">*</span></label>
                                                <select name="barcode_symbology" required class="form-control">
                                                    <option value="C39+" @if(old("barcode_symbology")=='C39+' || $product->barcode_symbology=='C39+') selected @endif>Code C39+</option>
                                                    <option value="C39" @if(old("barcode_symbology")=='C39' || $product->barcode_symbology=='C39') selected @endif>Code 39</option>
                                                    <option value="PDF417" @if(old("barcode_symbology")=='UPCA' || $product->barcode_symbology=='PDF417') selected @endif>PDF417</option>
                                                    {{--<option value="UPCE" @if(old("barcode_symbology")=='UPCE' || $product->barcode_symbology=='UPCE') selected @endif>UPC-E</option>
                                                    <option value="EAN8" @if(old("barcode_symbology")=='EAN8' || $product->barcode_symbology=='EAN8') selected @endif>EAN-8</option>
                                                    <option value="EAN13" @if(old("barcode_symbology")=='EAN13' || $product->barcode_symbology=='EAN13') selected @endif>EAN-13</option>--}}
                                                </select>
                                                <span class="text-danger"> {{$errors->has("barcode_symbology") ? $errors->first("barcode_symbology") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group select2-parent">
                                                <label>Brand <span class="text-danger">*</span></label>
                                                <select name="brand_id" id="brand_id" required class="form-control single-select2" style="width: 100%;">
                                                    <option selected value="">Select Brand</option>
                                                    @foreach($lims_brand_list as $brand)
                                                        <option value="{{$brand->id}}" @if(old("brand_id")==$brand->id || $product->brand_id==$brand->id) selected @endif>{{$brand->name}}</option>
                                                    @endforeach
                                                </select>
                                                <span class="text-danger"> {{$errors->has("brand_id") ? $errors->first("brand_id") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group select2-parent">
                                                <label>Category <span class="text-danger">*</span></label>
                                                <select name="category_id" id="category_id" required class="form-control single-select2" style="width: 100%;">
                                                    <option selected value="">Select Category</option>
                                                    @foreach($lims_category_list as $category)
                                                        <option value="{{$category->id}}" @if(old("category_id")==$category->id || $product->category_id==$category->id) selected @endif>{{$category->name}}</option>
                                                    @endforeach
                                                </select>
                                                <span class="text-danger"> {{$errors->has("category_id") ? $errors->first("category_id") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group select2-parent">
                                                <label>Unit <span class="text-danger">*</span></label>
                                                <select name="unit_id" id="unit_id" required class="form-control">
                                                    <option selected value="">Select Unit</option>
                                                    @foreach($lims_unit_list as $unit)
                                                        @if($unit->base_unit==null)
                                                            <option value="{{$unit->id}}" @if(old("unit_id")==$unit->id || $product->unit_id==$unit->id) selected @endif>{{$unit->name}}</option>
                                                        @endif
                                                    @endforeach
                                                </select>
                                                <span class="text-danger"> {{$errors->has("unit_id") ? $errors->first("unit_id") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Product Price</label>
                                                <input type="number" name="product_price" value="{{old("alert_quantity", $product->product_price)}}"
                                                       class="form-control {{$errors->has("product_price") ? "is-invalid":""}}" step="any" required>
                                                <span class="text-danger"> {{$errors->has("product_price") ? $errors->first("product_price") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Alert Quantity <span class="text-danger">*</span></label>
                                                <input type="number" name="alert_quantity" value="{{old("alert_quantity", $product->alert_quantity)}}"
                                                       class="form-control {{$errors->has("alert_quantity") ? "is-invalid":""}}" step="any" required>
                                                <span class="text-danger"> {{$errors->has("alert_quantity") ? $errors->first("alert_quantity") : ""}} </span>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="customFile">Attach Document</label>
                                                <i class="fa fa-question-circle" data-toggle="tooltip" title="" data-original-title="Only jpg, jpeg, png, gif, pdf, csv, docx, xlsx and txt file is supported"></i>
                                                <div class="custom-file">
                                                    <input type="file" class="custom-file-input" name="file" id="document">
                                                    <label class="custom-file-label" for="document">Choose file</label>
                                                </div>
                                                @if($product->file)
                                                    <a href="{{route('peodutFile.download',$product->id)}}">Download File</a>
                                                @endif
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="product_details">Product Details</label>
                                                <textarea class="txt-editor form-control" name="product_details">{{old('product_details', $product->product_details)}}</textarea>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label>Product Image</label>
                                                <i class="fa fa-question-circle" data-toggle="tooltip"
                                                   title="You can upload multiple image. Only .jpeg, .jpg, .png, .gif file can be uploaded. First image will be base image."></i>
                                                <div class="custom-file">
                                                    <input type="file" class="custom-file-input" name="image[]" id="image"
                                                           accept="image/png, image/gif, image/jpeg" multiple>
                                                    <label class="custom-file-label" for="image">Choose images</label>
                                                </div>
                                                @if($product->image)
                                                    @php
                                                        $images = json_decode($product->image)
                                                    @endphp
                                                    @if($images and count($images)>0)
                                                        @foreach($images as $img)
                                                            <a href="{{asset($img)}}" target="_blank"><img src="{{asset($img)}}" class="img-thumbnail" width="80px" height="80px"></a>
                                                        @endforeach
                                                    @endif
                                                @endif
                                            </div>
                                        </div>

                                        <div class="col-md-4">
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

@section('js')
    <script src="{{asset("/public/admin-lte/plugins/bs-custom-file-input/bs-custom-file-input.min.js")}}"></script>
    <script src="https://demo.codesbright.com/public/admin-lte/plugins/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            bsCustomFileInput.init();

            $('#genbutton').on("click", function(){
                $.get("{!! URL::to('/gencode') !!}", function(data){
                    $("input[name='code']").val(data);
                });
            });
            tinymceInitial();
        });
        $('[data-toggle="tooltip"]').tooltip();
    </script>
@endsection
