@extends("backend.master.main-layout")
@section("page-title","Add Transfer")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Add Transfer
                    </div>
                    <div class="card-body">
                        <form method="post" action="{{route('transfer.store')}}" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                            {{ csrf_field() }}

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="warehouse">From Warehouse<span class="text-red">*</span></label>
                                    <select
                                            class="form-control single-select2" required
                                            data-placeholder="Select Warehouse" data-allow-clear="true"
                                            id="from_warehouse_id" name="from_warehouse_id">
                                        <option></option>
                                        @foreach($warehouse_from as $warehouse_f)
                                            <option value="{{$warehouse_f->id}}" @if(old('from_warehouse_id') == $warehouse_f->id) selected @endif>{{ucwords($warehouse_f->name)}}</option>
                                        @endforeach
                                    </select>

                                    <span class="text-danger"> {{$errors->has("from_warehouse_id") ? $errors->first("from_warehouse_id") : ""}} </span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="warehouse">To Warehouse<span class="text-red">*</span></label>
                                    <select
                                            class="form-control single-select2"
                                            data-placeholder="Select Warehouse" data-allow-clear="true"
                                            id="to_warehouse_id" name="to_warehouse_id">
                                        <option></option>
                                        @foreach($warehouses as $warehouse)
                                            <option value="{{$warehouse->id}}" @if(old('to_warehouse_id') == $warehouse->id) selected @endif>{{ucwords($warehouse->name)}}</option>
                                        @endforeach
                                    </select>

                                    <span class="text-danger"> {{$errors->has("to_warehouse_id") ? $errors->first("to_warehouse_id") : ""}} </span>
                                </div>
                            </div>

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
                                            <th style="width: 15%; text-align: left;">Name</th>
                                            <th style="width: 10%; text-align: left;">Code</th>
                                            <th style="width: 10%; text-align: left;">Unit</th>
                                            <th style="width: 19%;">Quantity</th>
                                            <th style="width: 10%; text-align: left;">Unit Cost</th>
                                            <th style="width: 10%; text-align: left;">SubTotal</th>
                                            <th style="width: 7%; text-align: center;">Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        @if(!is_null(old("product_id")) && COUNT(old("product_id"))>0 && COUNT($errors->all())>0)
                                            <?php $trows = COUNT(old("product_id")); ?>
                                            @for($i=0; $trows>$i; $i++)
                                                <?php
                                                    $row = '';
                                                    $product = \App\Models\Product::find(old("product_id.$i"));
                                                    $unit = App\Models\Unit::find($product->unit_id);

                                                    $row .= '<tr>';
                                                    $row .= '<td>'.$product->name.'</td>';
                                                    $row .= '<td>'.$product->code.'</td>';
                                                    $row .= '<td>'.$unit->name.'</td>';

                                                    $qty_errom_msg = $errors->has("qty.$i") ? $errors->first("qty.$i") : '';
                                                    $row .= '<td>
                                                                <input type="hidden" class="form-control product_id" name="product_id[]" value="'.$product->id.'" required="" autocomplete="off">
                                                                <input type="number" class="form-control qty" name="qty[]" value="'.old("qty.$i").'" step="any" min="1" autocomplete="off">
                                                                <input type="hidden" class="avaiableQty" name="avaiableQty" value="'.old("avaiableQty.$i").'">
                                                                <span class="text-danger">'.$qty_errom_msg.'</span>
                                                            </td>';
                                                    $row .= '<td class="net_unit_cost text-center">'.$product->product_price.'
                                                            <input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                                                            <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
                                                        </td>';
                                                    $row .= '<td class="sub-total text-center">'.number_format(old("subtotal_input.$i"), 2).'</td>';
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

                                        </tbody>
                                        <tfoot class="tfoot active">
                                        <tr>
                                            <th colspan="3">Total</th>
                                            <th id="total-qty" class="text-center">{{ number_format(old("total_qty_input"), 2)}}</th>
                                            <th></th>
                                            <th id="total" class="text-center">{{ number_format(old("total_price_input"), 2) }}</th>
                                            <th></th>
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
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $('#live-search').select2({
                ajax: {
                    url: "{{route('transfer.get-product')}}",
                    type:"POST",
                    dataType:"JSON",
                    data: function (params) {
                        return  query = {
                            search: params.term,
                            warehouse_id: $("#from_warehouse_id").val(),
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

            $(document).on('select2:open', 'select.live-search', function (e) {
                var warehouse_id = $('select[name="from_warehouse_id"]').val();
                if(!warehouse_id){
                    $('#live-search').val(null).trigger('change.select2');
                    alert('Please select Warehouse!');
                    $(this).select2('close');
                }

            });
        });

        $(document).on('click','.btn-delete',function () {
            let deleteButton = $(this);
            deleteButton.closest('tr').remove();

            $("#total-qty").text(parseFloat(total_qty()).toFixed(2));
            $("#total").text(parseFloat(total_price()).toFixed(2));

            $("#total_qty_input").val(total_qty());
            $("#total_price_input").val(total_price());
        });

        var availabeQty = 0;
        var row_count = 1;
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
                        //alert($(result).closest('tr').find('.rows').text());
                        var mod = result.replace('id=""', 'id="'+row_count+'"');
                        $('#order-table tbody').prepend(mod);
                    },
                    complete: function (e) {
                        $('#live-search').val(null).trigger('change.select2');

                        // Ajax
                         $.ajax({
                            type: "POST",
                            url: "{!! route('transfer.get-available-qty') !!}",
                            data: {product_id: product_id, warehouse_id: $("#from_warehouse_id").val(), _token: _token},
                            //dataType : 'HTML',
                            success: function (ret) {
                                obj = JSON.parse(ret);
                                availabeQty = obj.qty;

                                $("#"+row_count).closest('tr').find('.avaiableQty').val(availabeQty);

                            },
                            complete: function (e) {
                                //if(!notrigger)
                                $(".qty").trigger('input');
                            }
                        });
                         // End ajax

                    }
                });
            }else{
                $('#live-search').val(null).trigger('change.select2');
            }

            row_count++;
        });

        $(document).on("input", ".qty", function(){
            var qty           = $(this).val();
            var net_unit_cost = $.trim($(this).closest('tr').find('.net_unit_cost').text());

            var product_id = $.trim($(this).closest('tr').find('.product_id').val());

            availabeQty = $(this).closest('tr').find('.avaiableQty').val();

            if(parseFloat(qty)>parseFloat(availabeQty)) {
                qty = qty.substring(0, qty.length - 1);

                $(this).val(qty);

                alert('Quantity exceeds stock quantity!. Available stock: '+availabeQty);
                return false;
            }

            var subtotal = parseFloat(qty*net_unit_cost).toFixed(2);
            $(this).closest('tr').find('.sub-total').text(subtotal);
            $(this).closest('tr').find('.subtotal-input').val(parseFloat(qty*net_unit_cost));

            $("#total-qty").text(parseFloat(total_qty()).toFixed(2));
            $("#total").text(parseFloat(total_price()).toFixed(2));

            $("#total_qty_input").val(total_qty());
            $("#total_price_input").val(total_price());
        });

        function total_qty(){
            var total = 0;
            $(".qty").each(function() {
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
