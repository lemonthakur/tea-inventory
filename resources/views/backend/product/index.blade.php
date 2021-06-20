@extends("backend.master.main-layout")
@section("page-title","Product List")
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
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Product List</h3>
                                <a href="{{route('product.create')}}" class="btn btn-primary float-right text-white">
                                    <i class="fas fa-plus-circle"></i>
                                    Add New
                                </a>
                            </div>
                            <!-- /.card-header -->
                            <?php
                                $page = \Request::get('page');
                                $page = empty($page) ? 1 : $page;
                                $sl = ($page-1)*20;
                                $l = 1;
                            ?>
                            <div class="card-body table-responsive">
                                <span>Displaying product from {{ ($products->total()) ? $sl+1 : 0 }} to {{ $sl+$products->count() }} out of total {{ $products->total() }}</span>
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Code</th>
                                        <th>Brand</th>
                                        <th>Category</th>
                                        <th>Quantity</th>
                                        <th>Waste</th>
                                        <th>Unit</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($products as $product)
                                        <?php
                                            $array = array();
                                            $array [] = $product->id;
                                            $array [] = $product->name;
                                            $array [] = $product->code;
                                            $array [] = $product->barcode_symbology;
                                            $array [] = $product->brand_id;
                                            $array [] = $product->brand->name;
                                            $array [] = $product->category_id;
                                            $array [] = $product->category->name;
                                            $array [] = $product->unit_id;
                                            $array [] = $product->unit->name;
                                            $array [] = $product->product_price;
                                            $array [] = $product->qty/$product->unit->value;
                                            $array [] = $product->status;
                                            $array [] = $product->alert_quantity;
                                            $array [] = $product->file;
                                            $array [] = $product->product_details;
                                            $array [] = implode(',', json_decode($product->image));
                                            if($product->file) $array [] = route('peodutFile.download', $product->id);
                                            else $array [] = '';
                                            $array [] = $product->waste_qty/$product->unit->value;

                                            $barcode_image = App\CustomClass\OwnLibrary::barcode_generator($product->code, $product->barcode_symbology);
                                        ?>
                                        <tr class="product-link" data-product="{{json_encode($array)}}" data-imagedata="{{$barcode_image}}">
                                            <td>{{ ++$sl }}</td>
                                            <td>
                                                @if($product->image)
                                                    @php
                                                        $images = json_decode($product->image)
                                                    @endphp
                                                    @if($images and count($images)>0)
                                                        <img src="{{asset($images[0])}}" width="80" height="80">
                                                    @endif

                                                @endif
                                            </td>
                                            <td>{{ $product->name }}</td>
                                            <td>{{ $product->code }}</td>
                                            <td>{{ $product->brand->name }}</td>
                                            <td>{{ $product->category->name }}</td>
                                            <td>{{ $product->qty/$product->unit->value }}</td>
                                            <td>{{ $product->waste_qty/$product->unit->value  }}</td>
                                            <td>{{ $product->unit->name }}</td>
                                            <td class="text-center">
                                                @if($product->status == 1)
                                                    <button class="btn btn-xs btn-success">Active</button>
                                                @else
                                                    <button class="btn btn-xs btn-danger">Inactive</button>
                                                @endif
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action
                                                        <span class="caret"></span>
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                                        <li>
                                                            <button type="button" class="btn btn-link view"><i class="fa fa-eye"></i> View
                                                            </button>
                                                        </li>
                                                        <li>
                                                            <a class="btn btn-link" href="{{route('product.edit',$product->id)}}" title="Edit">
                                                                <i class="fas fa-pencil-alt"></i> Edit
                                                            </a>
                                                        </li>
                                                        <form method="post" action="{{ route('product.destroy',$product->id) }}">
                                                            @method('delete')
                                                            @csrf
                                                            <li>
                                                                <button type="submit" class="btn btn-link delete" title="Delete">
                                                                    <i class="fas fa-trash-alt text-danger"></i> Delete
                                                                </button>
                                                            </li>
                                                        </form>
                                                    </ul>
                                                </div>

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
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{$products->links("backend.include.pagination")}}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

    <div id="product-details" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
        <div role="document" class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="exampleModalLabel" class="modal-title">{{'Product Details'}}</h5>
                    <button id="print-btn" type="button" class="btn btn-default btn-sm ml-3"><i class="fa fa-print"></i> {{'Print'}}</button>
                    <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-5" id="slider-content"></div>
                        <div class="col-md-5 offset-1" id="product-content"></div>
                        <div class="col-md-5 mt-2" id="product-warehouse-section">
                            <h5>Warehouse Quantity</h5>
                            <table class="table table-bordered table-hover product-warehouse-list">

                            </table>
                        </div>
                    </div>

                    <h5 id="combo-header"></h5>
                    <table class="table table-bordered table-hover item-list">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('js')
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("click", "tr.product-link td:not(:first-child, :last-child)", function() {
                productDetails( $(this).parent().data('product'), $(this).parent().data('imagedata') );
            });

            $(document).on("click", ".view", function(){
                var product = $(this).parent().parent().parent().parent().parent().data('product');
                var imagedata = $(this).parent().parent().parent().parent().parent().data('imagedata');
                productDetails(product, imagedata);
            });

            function productDetails(product, imagedata) {
                product[15] = product[15].replace(/@/g, '"');
                htmltext = slidertext = '';

                var act = (product[12] == 1) ? 'Active' : 'Inactive';
                var fil = (product[14]) ? 'Download File' : '';
                htmltext = '<p><strong>{{"Name"}}: </strong>'+product[1]+'</p><p><strong>{{"Code"}}: </strong>'+product[2]+ '</p>' +
                    '<strong>{{"Barcode"}}: </strong><img src="data:image/png;base64,'+imagedata+'" alt="barcode" /></p>' +
                    '<p><strong>{{"Brand"}}: </strong>'+product[5]+'</p><p><strong>{{"category"}}: </strong>'+product[7]+'</p>' +
                    '<p><strong>{{"Quantity"}}: </strong>'+product[11]+'</p><p><strong>{{"Waste"}}: </strong>'+product[18]+'</p><p><strong>{{"Unit"}}: </strong>'+product[9]+'</p>' +
                    '<p><strong>{{"Price"}}: </strong>'+ product[10]+'</p>' +
                    '<p><strong>{{"Alert Quantity"}} : </strong>'+product[13]+'</p>' +
                    '<p><strong>{{"File"}} : </strong><a href="'+ product[17]+'">'+fil+'</a></p>' +
                    '<p><strong>{{"Product Details"}}: </strong></p>'+product[15]+'<p><strong>{{"Status"}} : </strong>'+act+'</p>';

                if(product[16]) {
                    var product_image = product[16].split(",");
                    if(product_image.length > 1) {
                        slidertext = '<div id="product-img-slider" class="carousel slide" data-ride="carousel"><div class="carousel-inner">';
                        for (var i = 0; i < product_image.length; i++) {
                            if(!i)
                                slidertext += '<div class="carousel-item active"><img src="'+product_image[i]+'" height="300" width="100%"></div>';
                            else
                                slidertext += '<div class="carousel-item"><img src="'+product_image[i]+'" height="300" width="100%"></div>';
                        }
                        slidertext += '</div><a class="carousel-control-prev" href="#product-img-slider" data-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a><a class="carousel-control-next" href="#product-img-slider" data-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a></div>';
                    }
                    else {
                        slidertext = '<img src="'+product[16]+'" height="300" width="100%">';
                    }
                }

                $("#combo-header").text('');
                $("table.item-list thead").remove();
                $("table.item-list tbody").remove();
                //$("table.product-warehouse-list thead").remove();
                //$("table.product-warehouse-list tbody").remove();
                $(".product-variant-warehouse-list thead").remove();
                $(".product-variant-warehouse-list tbody").remove();
                $("#product-warehouse-section").addClass('d-none');
                $("#product-variant-warehouse-section").addClass('d-none');

                $('#product-content').html(htmltext);
                $('#slider-content').html(slidertext);
                $('#product-details').modal('show');
                $('#product-img-slider').carousel(0);

                $('.product-warehouse-list').html('');
                $.ajax({
                    type: "POST",
                    url: "{!! route('product-warehouse-qty.get') !!}",
                    data: {product_id: product[0], _token: "{{csrf_token()}}" },
                    //dataType : 'HTML',
                    success: function (result) {
                        $('.product-warehouse-list').html(result);
                    },
                    complete: function (e) {
                        $("#product-warehouse-section").removeClass('d-none');
                    }
                });

            }

            $("#print-btn").on("click", function(){
                var divToPrint=document.getElementById('product-details');
                var newWin=window.open('','Print-Window');
                newWin.document.open();
                newWin.document.write('<link rel="stylesheet" href="<?php echo asset('public/admin-lte/dist/css/adminlte.min.css') ?>" type="text/css"><style type="text/css">@media print {.modal-dialog { max-width: 1000px;} #print-btn, #close-btn {visibility: hidden;} }</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
