@extends("backend.master.main-layout")
@section("page-title","Add Purchase")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Add Purchase
                    </div>
                    <div class="card-body">
                        <form method="post" action="{{route('purchase.store')}}" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                            {{ csrf_field() }}

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="warehouse">Warehouse<span class="text-red">*</span></label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Warehouse" data-allow-clear="true"
                                        id="warehouse" name="warehouse">
                                        <option></option>
                                        @foreach($warehouses as $warehouse)
                                            <option value="{{$warehouse->id}}" @if(old('warehouse') == $warehouse->id) selected @endif>{{ucwords($warehouse->name)}}</option>
                                        @endforeach
                                    </select>

                                    <span class="text-danger"> {{$errors->has("warehouse") ? $errors->first("warehouse") : ""}} </span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="supplier">Supplier</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Supplier" data-allow-clear="true"
                                        id="supplier" name="supplier">
                                        <option></option>
                                        @foreach($suppliers as $supplier)
                                            <option value="{{$supplier->id}}" @if(old('supplier') == $supplier->id) selected @endif>{{ucwords($supplier->name)}}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>

                            {{--<div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="status">Purchase Status</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Status" data-allow-clear="true"
                                        id="status" name="status" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="1">Received</option>
                                        <option value="2">Partial</option>
                                        <option value="3">Pending</option>
                                        <option value="4">Ordered</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>--}}

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="file">
                                        Attach Document
                                        <i class="far fa-question-circle" data-toggle="tooltip" data-placement="top"
                                           title="Only jpg, jpeg, png, gif, pdf, csv, docx, xlsx and txt file is supported"></i>
                                    </label>
                                    <input id="file" type="file" class="form-control" name="document" />
                                    <span class="text-danger"> {{$errors->has("document") ? $errors->first("document") : ""}} </span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group select2-parent">
                                    <label for="product">Select Product</label>
                                    <select name="product" class="form-control live-search live-search-pro" id="live-search" style="width: 100%;">
                                        <option></option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <h5>Order Table *</h5>
                                <div class="table-responsive mt-3">
                                    <table id="order-table" class="table table-hover order-list" style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th style="width: 15%;">Name</th>
                                            <th style="width: 15%;">Code</th>
                                            <th style="width: 19%;">Quantity</th>
                                            <th style="width: 19%">Waste</th>
                                            <th style="width: 15%">Net Unit Cost</th>
                                            <th style="width: 10%">SubTotal</th>
                                            <th style="width: 7%">Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        @if(!is_null(old("product_id")) && COUNT(old("product_id"))>0 && COUNT($errors->all())>0)
                                            <?php $trows = COUNT(old("product_id")); ?>
                                            @for($i=0; $trows>$i; $i++)
                                                <?php
                                                        //dd($errors);
                                                    $row = '';
                                                    $product = \App\Models\Product::find(old("product_id.$i"));
                                                    $row .= '<tr>';
                                                    $row .= '<td>'.$product->name.'</td>';
                                                    $row .= '<td>'.$product->code.'</td>';
                                                    $qty_errom_msg = $errors->has("qty.$i") ? $errors->first("qty.$i") : '';
                                                    $waste_errom_msg = $errors->has("waste.$i") ? $errors->first("waste.$i") : '';
                                                    $row .= '<td>
                                                                <input type="hidden" class="form-control product_id" name="product_id[]" value="'.$product->id.'" required="" autocomplete="off">
                                                                <input type="number" class="form-control qty" name="qty[]" value="'.old("qty.$i").'" step="any" min="1" autocomplete="off">
                                                                <span class="text-danger">'.$qty_errom_msg.'</span>
                                                            </td>';
                                                    $row .= '<td>
                                                                <input type="number" class="form-control waste" name="waste[]" value="'.old("waste.$i").'" step="any">
                                                                <span class="text-danger">'.$waste_errom_msg.'</span>
                                                            </td>';
                                                    $row .= '<td class="net_unit_cost">'.$product->product_price.'
                                                            <input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                                                            <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
                                                        </td>';
                                                    $row .= '<td class="sub-total">'.old("subtotal_input.$i").'</td>';
                                                    $row .= '<input type="hidden" class="subtotal-input" name="subtotal_input[]" value="'.old("subtotal_input.$i").'">';
                                                    $row .= '<td>
                                                               <div>
                                                                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                                                                       <i class="far fa-trash-alt"></i>
                                                                   </button>
                                                               </div>
                                                            </td>';
                                                    $row .= '</tr>';
                                                ?>
                                                {!! $row !!}
                                            @endfor
                                        @endif


                                        {{--<tr>
                                            <td>
                                                mango
                                            </td>
                                            <td>72782608</td>
                                            <td>
                                                <input type="number" class="form-control qty" name="qty[]" value="1" step="any" required="">
                                            </td>
                                            <td>
                                                <input type="number" class="form-control qty" name="qty[]" value="1" step="any" required="">
                                            </td>
                                            <td class="net_unit_cost">166.96</td>
                                            <td class="sub-total">192.00</td>
                                            <td>
                                               <div>
                                                   <button type="button" class="btn btn-warning btn-xs btn-edit" title="edit"
                                                           data-toggle="modal" data-target=".edit-product">
                                                       <i class="far fa-edit"></i>
                                                   </button>
                                                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                                                       <i class="far fa-trash-alt"></i>
                                                   </button>
                                               </div>
                                            </td>
                                        </tr>--}}
                                        </tbody>
                                        <tfoot class="tfoot active">
                                        <tr>
                                            <th colspan="2">Total</th>
                                            <th id="total-qty">0.00</th>
                                            <th colspan="2" id="total-waste">0.00</th>
                                            <th colspan="2" id="total">0.00</th>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="Note">Note</label>
                                    <textarea id="Note" class="form-control" name="note">{{ old('note') }}</textarea>
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <input type="hidden" id="total_qty_input" name="total_qty_input" value="{{ old("total_qty_input")}}" />
                            <input type="hidden" id="total_price_input" name="total_price_input" value="{{ old("total_price_input") }}" />
                            <input type="hidden" id="total_waste_input" name="total_waste_input" value="{{ old("total_waste_input") }}" />

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

    {{--<div class="modal fade edit-product" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"
         data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Product Name</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input type="number" name="edit_qty" class="form-control" step="any">
                                </div>
                            </div>
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Unit Discount</label>
                                   <input type="number" name="edit_discount" class="form-control" step="any">
                               </div>
                           </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Unit Cost</label>
                                    <input type="number" name="edit_unit_cost" class="form-control" step="any">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="order_tax_rate">Order Tax</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Tax" data-allow-clear="true"
                                        id="order_tax_rate" name="order_tax_rate" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="0">No Tax</option>
                                        <option value="10">vat@10</option>
                                        <option value="15">vat@15</option>
                                        <option value="20">vat 20</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="edit_unit">Product Unit</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Tax" data-allow-clear="true"
                                        id="edit_unit" name="edit_unit" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="0">cartoon box</option>
                                        <option value="1">Piece</option>
                                        <option value="2">dozen box</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Update</button>
                </div>
            </div>
        </div>
    </div>
    </div>--}}
@endsection

@section('js')
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $('#live-search').select2({
                ajax: {
                    url: "{{route('ser-product.get')}}",
                    type:"POST",
                    dataType:"JSON",
                    data: function (params) {
                        return  query = {
                            search: params.term,
                            _token: "{{csrf_token()}}"
                        }
                    },

                    processResults: function (response) {
                        return {
                            results: response
                        };
                    },
                },
                placeholder: 'Search by product name or product code',
                minimumInputLength: 2,
            });
        });

        $(document).on('click','.btn-delete',function () {
            let deleteButton = $(this);
            deleteButton.closest('tr').remove();

            $("#total-qty").text(parseFloat(total_qty()).toFixed(2));
            $("#total-waste").text(parseFloat(total_waste()).toFixed(2));
            $("#total").text(parseFloat(total_price()).toFixed(2));

            $("#total_qty_input").val(total_qty());
            $("#total_waste_input").val(total_waste());
            $("#total_price_input").val(total_price());
        });

        var _token = $('input[name="_token"]').val();

        $(document).on("change", ".live-search-pro", function(){
            var product_id = $(this).val();

            var meke_req = true;
            $(".product_id").filter(function () {
                if($.trim($(this).val()) == product_id) meke_req = false;
            });

            if(meke_req) {
                $.ajax({
                    type: "POST",
                    url: "{!! route('product-wise-row.get') !!}",
                    data: {product_id: product_id, _token: _token},
                    //dataType : 'HTML',
                    success: function (result) {
                        $('#order-table tbody').prepend(result);
                    },
                    complete: function (e) {
                        //$('#live-search').trigger('select2');
                        //$("#live-search").val('').select2();
                        //$('#live-search').select2('data', {id: '', a_key: ''});
                        //$('#live-search').val(''); // Select the option with a value of '1'
                        //$('#live-search').trigger('change'); // Notify any JS components that the value changed
                        //spinnerB.hide();
                        $(".qty").trigger('input');
                    }
                });
            }
        });

        $(document).on("input", ".qty", function(){
            var qty           = $(this).val();
            var net_unit_cost = $.trim($(this).closest('tr').find('.net_unit_cost').text());

            var subtotal = parseFloat(qty*net_unit_cost).toFixed(2);
            $(this).closest('tr').find('.sub-total').text(subtotal);
            $(this).closest('tr').find('.subtotal-input').val(parseFloat(qty*net_unit_cost));

            $("#total-qty").text(parseFloat(total_qty()).toFixed(2));
            $("#total-waste").text(parseFloat(total_waste()).toFixed(2));
            $("#total").text(parseFloat(total_price()).toFixed(2));

            $("#total_qty_input").val(total_qty());
            $("#total_waste_input").val(total_waste());
            $("#total_price_input").val(total_price());
        });

        $(document).on("input", ".waste", function(){
            $(".qty").trigger('input');
        });

        function total_qty(){
            var total = 0;
            $(".qty").each(function() {
                total += parseFloat($(this).val());
            });
            if(isNaN(total)) return 0;
            return total;
        }

        function total_waste(){
            var total = 0;
            $(".waste").each(function() {
                total += parseFloat($(this).val());
            });
            if(isNaN(total)) return 0;
            return total;
        }

        function total_price(){
            var total = 0;
            $(".sub-total").each(function() {
                total += parseFloat($(this).text());
            });
            if(isNaN(total)) return 0;
            return total;

        }
    </script>
@endsection
