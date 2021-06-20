@extends("backend.master.main-layout")
@section("page-title","Print Label")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Print Label
                    </div>
                    <div class="card-body">
                            <div class="row">
                            {{ csrf_field() }}

                            <div class="col-md-12">
                                <div class="table-responsive mt-3">
                                    <table id="order-table" class="table table-hover order-list" style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th class="text-left" style="">Name</th>
                                            <th class="text-left" style="">Supplier</th>
                                            <th class="text-left" style="">Warehouse</th>
                                            <th class="text-left" style="">Price</th>
                                            <th class="text-left" style="">Quantity</th>
                                            <th class="text-left" style="">Order number</th>
                                            <th class="text-left" style="">Code</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($lims_product_purchase_data as $v)
                                                <?php $barcode_image = App\CustomClass\OwnLibrary::barcode_generator($v->product->id.'~'.$purchase->id.'~'.$purchase->reference_no, $v->product->barcode_symbology); ?>

                                                <tr data-imagedata="{{$barcode_image}}" data-price="{{number_format($v->total, 2)}}">
                                                    <td>{{$v->product->name}}</td>
                                                    <td>{{$purchase->supplier->name}}</td>
                                                    <td>{{$purchase->warehouse->name}}</td>
                                                    <td class="text-center">{{number_format($v->qty, 2)}}</td>
                                                    <td class="text-center">{{number_format($v->total, 2)}}</td>
                                                    <td class="">{{$purchase->reference_no}}</td>
                                                    <td class="product-code">{{$v->product->code}}</td>
                                                    <td><input type="hidden" class="form-control qty" name="qty[]" value="1" /></td>
                                                </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group mt-2">
                                    <strong>Print: </strong>&nbsp;
                                    <strong><input type="checkbox" name="name" checked /> Product Name</strong>&nbsp;
                                    <strong><input type="checkbox" name="supplier" checked /> Supplier</strong>&nbsp;
                                    <strong><input type="checkbox" name="warehouse" checked /> Warehouse</strong>&nbsp;
                                    <strong><input type="checkbox" name="code" checked /> Price</strong>&nbsp;
                                    <strong><input type="checkbox" name="quantity" checked /> Quantity</strong>&nbsp;
                                    <strong><input type="checkbox" name="code" checked /> Order number</strong>&nbsp;
                                    <strong><input type="checkbox" name="code" checked /> Product Code</strong>&nbsp;
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group mt-2 select2-parent">
                                    <strong>Paper Size *: </strong>&nbsp;
                                    <select class="form-control single-select2"
                                        data-allow-clear="true"
                                        id="paper-size" name="paper_size" width="100%">
                                        <option value="0">Select paper size...</option>
                                        <option value="36">36 mm (1.4 inch)</option>
                                        <option value="24">24 mm (0.94 inch)</option>
                                        <option value="18">18 mm (0.7 inch)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button type="submit" class="btn btn-primary" id="submit-button">Generate</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

    <div id="print-barcode" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
        <div role="document" class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                  <h5 id="modal_header" class="modal-title">Barcode</h5>&nbsp;&nbsp;
                  <button id="print-btn" type="button" class="btn btn-default btn-sm"><i class="fa fa-print"></i>Print</button>
                  <button type="button" id="close-btn" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                <div class="modal-body">
                    <div id="label-content">
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('js')
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();


            $("#submit-button").on("click", function(event){
            paper_size = ($("#paper-size").val());

            if(paper_size != "0") {
                var product_name = [];
                var code = [];
                var price = [];
                var promo_price = [];
                var qty = [];
                var barcode_image = [];

                var supplier = [];
                var warehouse = [];
                var quantity = [];
                var rownumber = $('table.order-list tbody tr:last').index();
                for(i = 0; i <= rownumber; i++){
                    product_name.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('td:nth-child(1)').text());
                    code.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('td:nth-child(7)').text());
                    price.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').data('price'));
                    promo_price.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').data('promo-price'));
                    qty.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('.qty').val());
                    barcode_image.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').data('imagedata'));

                    supplier.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('td:nth-child(2)').text());
                    warehouse.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('td:nth-child(3)').text());
                    quantity.push($('table.order-list tbody tr:nth-child(' + (i + 1) + ')').find('td:nth-child(5)').text());
                }
                var htmltext = '<table class="barcodelist" style="width: 100%" cellpadding="5px" cellspacing="10px">';
                $.each(qty, function(index){
                    i = 0;
                    while(i < qty[index]) {
                        if(i % 2 == 0)
                            htmltext +='<tr>';
                        // 36mm
                        if(paper_size == 36)
                            htmltext +='<td style="width:164px;height:88%;padding-top:7px;vertical-align:middle;text-align:center">';
                        //24mm
                        else if(paper_size == 24)
                            htmltext +='<td style="width:164px;height:100%;font-size:12px;text-align:center">';
                        //18mm
                        else if(paper_size == 18)
                            htmltext +='<td style="width:164px;height:100%;font-size:10px;text-align:center">';

                        if($('input[name="name"]').is(":checked"))
                            htmltext += product_name[index] + '<br>';

                        if($('input[name="supplier"]').is(":checked"))
                            htmltext += supplier[index] + '<br>';

                        if($('input[name="warehouse"]').is(":checked"))
                            htmltext += warehouse[index] + '<br>';

                        if($('input[name="quantity"]').is(":checked"))
                            htmltext += quantity[index] + '<br>';

                        if(paper_size == 18)
                            htmltext += '<img style="max-width:150px;" src="data:image/png;base64,'+barcode_image[index]+'" alt="barcode" /><br>';
                        else
                            htmltext += '<img style="max-width:150px;" src="data:image/png;base64,'+barcode_image[index]+'" alt="barcode" /><br>';

                        if($('input[name="code"]').is(":checked"))
                            htmltext += '<strong>'+code[index]+'</strong><br>';

                        if($('input[name="price"]').is(":checked"))
                            htmltext += 'price: '+price[index];

                        htmltext +='</td>';
                        if(i % 2 != 0)
                            htmltext +='</tr>';
                        i++;
                    }

                });
                htmltext += '</table">';
                $('#label-content').html(htmltext);
                $('#print-barcode').modal('show');
            }
            else
                alert('Please select paper size');
        });

        $("#print-btn").on("click", function() {
              var divToPrint=document.getElementById('print-barcode');
              var newWin=window.open('','Print-Window');
              newWin.document.open();
              newWin.document.write('<style type="text/css">@media  print { #modal_header { display: none } #print-btn { display: none } #close-btn { display: none } } table.barcodelist { page-break-inside:auto } table.barcodelist tr { page-break-inside:avoid; page-break-after:auto }</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
              newWin.document.close();
              setTimeout(function(){newWin.close();},10);
        });
    });

    </script>
@endsection
