@extends("backend.master.main-layout")
@section("page-title","Production-Show")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Production Details of <strong>{{$production->product->name}}</strong> ({{strtoupper($production->production_number)}})
                    </div>
                    <div class="card-body">
                        <div id="prin-table">
                        <table class="table table-bordered production-table">
                            <tr>
                                <th style="text-align: center;vertical-align: middle;" colspan="4">
                                    <h5 style="margin: 0;font-size: 20px">Producing Product Details</h5>
                                </th>
                            </tr>
                            <tr>
                                <th>Product Name</th>
                                <td>{{ucwords($production->product->name)}}</td>
                                <th>Production Code</th>
                                <td>{{$production->production_number}}</td>
                            </tr>
                            <tr>
                                <th>Warehouse</th>
                                <td>{{$production->warehouse->name ?? ''}}</td>
                                <th>Employee</th>
                                <td>{{ucwords($production->employee->name) ?? ''}}</td>
                            </tr>
                            <tr>
                                <th>Produce Amount</th>
                                <td>{{$production->produce_amount}}</td>
                                <th>Waste</th>
                                <td>{{$production->waste_amount}}</td>
                            </tr>
                            <tr>
                                <th>Unit</th>
                                <td>{{$production->unit_name}}</td>
                                <th>Note</th>
                                <td>{{$production->note}}</td>
                            </tr>
                            <tr>
                                <th>Status</th>
                                <td>
                                    @if($production->status == 1)
                                        <label class="btn btn-xs btn-success">Finished</label>
                                    @else
                                        <label class="btn btn-xs btn-warning">On going</label>
                                    @endif
                                </td>
                                <th></th>
                                <td></td>
                            </tr>
                            <tr>
                                <th style="text-align: center;vertical-align: middle;" colspan="4">
                                    <h5 style="margin: 0;font-size: 20px">Product Used For Produced</h5>
                                </th>
                            </tr>
                            @foreach($production->productionUse as $product)
                                <tr style="background-color: #80808040;">
                                    <th colspan="4" style="text-align: center;vertical-align: middle;">Product{{$loop->iteration}}</th>
                                </tr>
                                <tr>
                                    <th>Product Name</th>
                                    <td>
                                       {{ucwords($product->product->name ?? '')}}
                                    </td>
                                    <th>Warehouse</th>
                                    <td>{{ucwords($product->warehouse->name ?? '')}}</td>
                                </tr>
                                <tr>
                                    <th>Qty</th>
                                    <td>
                                        {{ucwords($product->qty ?? '')}}
                                    </td>
                                    <th>Unit</th>
                                    <td>{{ucwords($product->unit_name ?? '')}}</td>
                                </tr>
                            @endforeach
                        </table>
                        </div>
                        <div class="my-2 text-right">
                            <a href="{{url()->previous()}}" class="btn btn-info">Go back</a>
                            @if(!empty($aclList[18][7]))
                            <button id="print-btn" type="button" class="btn btn-primary">Print</button>
                                @endif
                        </div>
                    </div>
                </div>

            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection
@section('js')
    <script>
        $("#print-btn").on("click", function() {
            var divToPrint=document.getElementById('prin-table');
            var newWin=window.open('','Print-Window');
            newWin.document.open();
            newWin.document.write('<style type="text/css">@media  print' +
                ' table.production-table { page-break-inside:auto; }' +
                ' table.production-table tr { page-break-inside:avoid; page-break-after:auto;}' +
                ' table.production-table {border: 1px solid black;border-collapse: collapse;width: 100%}' +
                ' table.production-table th {border: 1px solid black;text-align: left;padding: 2px 5px; vertical-align: middle}' +
                ' table.production-table td {border: 1px solid black;text-align: left;padding: 2px 5px;vertical-align: middle}' +
                '</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
            newWin.document.close();
            setTimeout(function(){newWin.close();},10);
        });
    </script>
@endsection

