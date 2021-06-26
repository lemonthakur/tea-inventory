@extends("backend.master.main-layout")
@section("page-title","Production-Create")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Add Production
                    </div>
                    <div class="card-body">
                        <form method="post" action="{{route('production.store')}}" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                                {{ csrf_field() }}

                                <input type="hidden" id="csrfToken" value="{{csrf_token()}}">

                                <input type="hidden" id="productProduceRoute" value="{{route('ser-product.get')}}">
                                <input type="hidden" id="productNeedRoute" value="{{route('transfer.get-product')}}">
                                <input type="hidden" id="addTocart" value="{{route('production.add.cart')}}">
                                <input type="hidden" id="removeCart" value="{{route('production.remove.cart')}}">

                                <div class=""></div>

                                <div class="col-md-6">
                                    <div class="form-group select2-parent">
                                        <label for="product">Product to Produce<span class="text-red">*</span></label>
                                        <select name="product" class="form-control product-produce" id="product-produce" style="width: 100%;" data-allow-clear="true">
                                            <option></option>
                                        </select>
                                        <span class="text-danger"> {{$errors->has("product") ? $errors->first("product") : ""}} </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="targate_amount">Produce Target Amount <span class="text-red">*</span></label>
                                        <input name="targate_amount" type="number" step="any" class="form-control" id="targate_amount" min="0"/>
                                        <span class="text-danger"> {{$errors->has("targate_amount") ? $errors->first("targate_amount") : ""}} </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="ref_no">Reference No. <span class="text-red">*</span></label>
                                        <input name="ref_no" type="text" step="any" class="form-control" id="ref_no" min="0"/>
                                        <span class="text-danger"> {{$errors->has("ref_no") ? $errors->first("ref_no") : ""}} </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Barcode Symbology <span class="text-danger">*</span></label>
                                        <select name="barcode_symbology" required class="form-control">
                                            <option value="C39+" @if(old("code")=='C39+') selected @endif>Colde C39+</option>
                                            <option value="C39" @if(old("code")=='C39') selected @endif>Code 39</option>
                                            {{--<option value="PDF417" @if(old("code")=='PDF417') selected @endif>PDF417</option>--}}
                                            {{--<option value="UPCE" @if(old("code")=='UPCE') selected @endif>UPC-E</option>
                                            <option value="EAN8" @if(old("code")=='EAN8') selected @endif>EAN-8</option>
                                            <option value="EAN13" @if(old("code")=='EAN13') selected @endif>EAN-13</option>--}}
                                        </select>
                                        <span class="text-danger"> {{$errors->has("barcode_symbology") ? $errors->first("barcode_symbology") : ""}} </span>
                                    </div>
                                </div>
{{--                                product need to produce product--}}
                               <div class="col-md-12">
                                   <div class="row m-2 pt-2">
                                       <div class="col-md-12">
                                           <h5>Select Necessary Product</h5>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="form-group select2-parent">
                                               <label for="warehouse">Warehouse<span class="text-red">*</span></label>
                                               <select
                                                   class="form-control single-select2"
                                                   data-placeholder="Select Warehouse" data-allow-clear="true"
                                                   id="nWarehouseId">
                                                   <option></option>
                                                   @foreach($warehouses as $warehouse)
                                                       <option value="{{$warehouse->id}}">{{ucwords($warehouse->name)}}</option>
                                                   @endforeach
                                               </select>

                                               <span class="text-danger"></span>
                                           </div>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="form-group select2-parent">
                                               <label for="product">Select Product<span class="text-red">*</span></label>
                                               <select class="form-control live-search live-search-pro" id="nproductId" style="width: 100%;" data-allow-clear="true">
                                                   <option></option>
                                               </select>
                                               <span class="text-danger"></span>
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="form-group select2-parent">
                                               <label for="product">Qty<span class="text-red">*</span></label>
                                               <input type="number" step="any" class="form-control" id="nQty" min="0"/>
                                               <span class="text-danger"></span>
                                           </div>
                                       </div>
                                       <div class="col-md-2 text-right">
                                           <button type="button" style="margin-top: 20%;" id="nBtn" class="btn btn-info">Add</button>
                                       </div>
                                   </div>
                               </div>


                                <div class="col-md-12">
                                    <h5>Necessary Product *</h5>
                                    <div class="table-responsive mt-3">
                                        <table id="order-table" class="table table-hover order-list" style="width: 100%;">
                                            <thead>
                                            <tr>
                                                <th style="text-align: left;">Name</th>
                                                <th style="text-align: left;">Code</th>
                                                <th style="text-align: left;">Unit</th>
                                                <th style="text-align: left;">Warehouse</th>
                                                <th>Quantity</th>
                                                <th style=" text-align: center;">Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            @if(Cart::count() > 0)
                                                @foreach(Cart::content() as $row)
                                                <tr>
                                                    <td>{{$row->name}}</td>
                                                    <td>{{$row->options['productCode']}}</td>
                                                    <td>{{$row->options['unit']}}</td>
                                                    <td>{{$row->options['warehouseName']}}</td>
                                                    <td>{{$row->qty}}</td>
                                                    <td class="text-center">
                                                        <button  rowId="{{$row->rowId}}" type="button" class="btn btn-danger btn-xs removeCart">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                @endforeach
                                            @endif
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="Note">Note</label>
                                        <textarea id="Note" class="form-control" name="note">{{ old('note') }}</textarea>
                                        <span class="text-danger"> {{$errors->has("note") ? $errors->first("note") : ""}} </span>
                                    </div>
                                </div>

                                <div class="col-md-12 text-right">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection

@section('js')
    <script src="{{asset("public/custom/product-produce.js")}}"></script>
    @endsection
