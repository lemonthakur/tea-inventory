@extends("backend.master.main-layout")
@section("page-title","Update Adjustment")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Update Adjustment
                    </div>
                    <div class="card-body">
                        <form method="post" action="{{route('qty_adjustment.update',$adjustment->id)}}" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                            {{ csrf_field() }}
                            @method('put')

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="warehouse">Warehouse<span class="text-red">*</span></label>
                                    <select
                                            class="form-control single-select2"
                                            data-placeholder="Select Warehouse" data-allow-clear="true"
                                            id="warehouse_id" name="warehouse_id">
                                        <option></option>
                                        @foreach($warehouses as $warehouse)
                                            <option value="{{$warehouse->id}}" @if(old('warehouse_id') == $warehouse->id || $adjustment->warehouse_id == $warehouse->id) selected @endif>{{ucwords($warehouse->name)}}</option>
                                        @endforeach
                                    </select>

                                    <span class="text-danger"> {{$errors->has("warehouse_id") ? $errors->first("warehouse_id") : ""}} </span>
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
                                    @if($adjustment->document)
                                        <a href="{{route('adjustmentFile.download',$adjustment->id)}}">Download File</a>
                                    @endif
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
                                            <th style="width: 10%; text-align: left;">Name</th>
                                            <th style="width: 10%; text-align: left;">Code</th>
                                            <th style="width: 10%; text-align: left;">Unit</th>
                                            <th style="width: 19%;">Quantity</th>
                                            <th style="width: 19%; text-align: center;">Action</th>
                                            <th style="width: 7%; text-align: center;"><i class="far fa-trash-alt"></i></th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <?php
                                            $total_qty_input = 0;
                                        ?>
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
                                                                <span class="text-danger">'.$qty_errom_msg.'</span>
                                                            </td>';
                                                    $row .= '<input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                                                            <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
                                                            <input type="hidden" class="subtotal-input" name="subtotal_input[]" value="'.old("subtotal_input.$i").'">';

                                                    $row .= '<td>
                                                            <select class="form-control" name="action[]" required>
                                                                <option value="">Select</option>
                                                                <option value="+" '.((old("action.$i")=='+')?'selected="selected"':"").'>Addition</option>
                                                                <option value="-" '.((old("action.$i")=='-')?'selected="selected"':"").'>Subtraction</option>
                                                            </select>
                                                            </td>';

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
                                        @else
                                            @foreach($product_adjustment_data as $product_adjustment)
                                                <?php
                                                $row = '';
                                                $product = \App\Models\Product::find($product_adjustment->product_id);
                                                $unit = App\Models\Unit::find($product->unit_id);

                                                $row .= '<tr>';
                                                $row .= '<td>'.$product->name.'</td>';
                                                $row .= '<td>'.$product->code.'</td>';
                                                $row .= '<td>'.$unit->name.'</td>';

                                                $row .= '<td>
                                                            <input type="hidden" class="form-control product_id" name="product_id[]" value="'.$product->id.'" required="" autocomplete="off">
                                                            <input type="number" class="form-control qty" name="qty[]" value="'.(($product_adjustment->qty)? $product_adjustment->qty / $unit->value : 0 ) .'" step="any" min="1" autocomplete="off">
                                                        </td>';
                                                $row .= '<input type="hidden" class="form-control unit_price" name="unit_price[]" value="'.$product->product_price.'">
                                                         <input type="hidden" class="form-control unit_id" name="unit_id[]" value="'.$product->unit_id.'">
                                                         <input type="hidden" class="subtotal-input" name="subtotal_input[]" value="">';
                                                $row .= '<td>
                                                            <select class="form-control" name="action[]" required>
                                                                <option value="">Select</option>
                                                                <option value="+" '.(($product_adjustment->action=='+')?'selected="selected"':"").'>Addition</option>
                                                                <option value="-" '.(($product_adjustment->action=='-')?'selected="selected"':"").'>Subtraction</option>
                                                            </select>
                                                         </td>';

                                                $row .= '<td>
                                                           <div>
                                                               <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                                                                   <i class="far fa-trash-alt"></i>
                                                               </button>
                                                           </div>
                                                        </td>';
                                                $row .= '</tr>';

                                                $total_qty_input += $product_adjustment->qty/$unit->value;
                                                ?>
                                                {!! $row !!}
                                            @endforeach
                                        @endif

                                        </tbody>
                                        <tfoot class="tfoot active">
                                        <tr>
                                            <th colspan="3">Total</th>
                                            <th id="total-qty" class="text-center">{{ number_format(old("total_qty_input", $total_qty_input), 2)}}</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="Note">Note</label>
                                    <textarea id="Note" class="form-control" name="note">{{ old('note', $adjustment->note) }}</textarea>
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
                    url: "{{route('adjustment.get-product')}}",
                    type:"POST",
                    dataType:"JSON",
                    data: function (params) {
                        return  query = {
                            search: params.term,
                            warehouse_id: $("#warehouse_id").val(),
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
                var warehouse_id = $('select[name="warehouse_id"]').val();
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
                    url: "{!! route('adjustment-product-warehouse-qty.get') !!}",
                    data: {product_id: product_id, _token: _token},
                    //dataType : 'HTML',
                    success: function (result) {
                        //alert($(result).closest('tr').find('.rows').text());
                        var mod = result.replace('id=""', 'id="'+row_count+'"');
                        $('#order-table tbody').prepend(mod);
                    },
                    complete: function (e) {
                        $('#live-search').val(null).trigger('change.select2');
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
