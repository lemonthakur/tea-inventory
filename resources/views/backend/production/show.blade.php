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
                        <div id="print-table">
                        <table class="table table-bordered production-table">
                            <tr>
                                <th style="text-align: center;vertical-align: middle;" colspan="4">
                                    <h5 style="margin: 0;font-size: 20px">Producing Product Details</h5>
                                </th>
                            </tr>
                            <tr>
                                <th>Production Code</th>
                                <td style="text-align: right">{{$production->production_number}}</td>
                                <th>Product Name</th>
                                <td style="text-align: right">{{ucwords($production->product->name)}}</td>
                            </tr>
                            <tr>
                                <th>Target Produce Amount</th>
                                <td style="text-align: right">
                                    {{number_format($production->targate_amount,2)}}
                                    {{ucwords($production->unit_name) ?? ''}}
                                </td>
                                <th>Produce Amount</th>
                                <td style="text-align: right">
                                    {{number_format($production->produce_amount,2)}}
                                    {{ucwords($production->unit_name) ?? ''}}
                                </td>
                            </tr>
                            <tr>
                                <th>Waste</th>
                                <td style="text-align: right">
                                    {{number_format($production->waste_amount,2)}}
                                    {{ucwords($production->unit_name) ?? ''}}
                                </td>
                                <th>Note</th>
                                <td style="text-align: right">{{$production->note}}</td>
                            </tr>
                            <tr>
                                <th>Warehouse</th>
                                <td style="text-align: right">{{$production->warehouse->name ?? ''}}</td>
                                <th>Employee</th>
                                <td style="text-align: right">{{ucwords($production->employee->name) ?? ''}}</td>
                            </tr>
                            <tr>
                                <th>Start At</th>
                                <td style="text-align: right">{{date('d M, Y',strtotime($production->created_at))}}</td>
                                <th>End At</th>
                                <td style="text-align: right">
                                    @if($production->status == 1)
                                        {{date('d M, Y',strtotime($production->updated_at))}}
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <th>Reference No.</th>
                                <td style="text-align: right">{{$production->ref_no ?? ''}}</td>
                                <th>Status</th>
                                <td style="text-align: right">
                                    @if($production->status == 1)
                                        <label class="btn btn-xs btn-success">Finished</label>
                                    @else
                                        <label class="btn btn-xs btn-warning">On going</label>
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: center;vertical-align: middle;" colspan="4">
                                    <h5 style="margin: 0;font-size: 20px">Product Used For Produced</h5>
                                </th>
                            </tr>
                            @foreach($production->productionUse as $product)
                                <tr style="background-color: #80808040;">
                                    <th colspan="4" style="text-align: center;vertical-align: middle;">Product Name: {{ucwords($product->product->name ?? '')}}</th>
                                </tr>
                                <tr>
                                    <th>Warehouse</th>
                                    <td style="text-align: right">{{ucwords($product->warehouse->name ?? '')}}</td>
                                    <th>Qty</th>
                                    <td style="text-align: right">
                                        {{number_format($product->qty,2)}}
                                        {{ucwords($product->unit_name ?? '')}}
                                    </td>
                                </tr>
                            @endforeach
                            <tr>
                                <th style="text-align: center;vertical-align: middle;" colspan="6">
                                    <h5 style="margin: 0;font-size: 20px">Worker Produce</h5>
                                </th>
                            </tr>
                            @foreach($production->employees as $employee)
                                <tr style="background-color: #80808040;">
                                    <th colspan="4" style="text-align: center;vertical-align: middle;">Employee Name: {{ucwords($employee->employee_name ?? '')}}</th>
                                </tr>
                                <tr>
                                    <th>Produce Amount</th>
                                    <td style="text-align: right">
                                        {{number_format($employee->produce_amount,2)}}
                                        {{ucwords($production->unit_name) ?? ''}}
                                    </td>
                                    <th>Waste Amount</th>
                                    <td style="text-align: right">
                                        {{number_format($employee->waste_amount,2)}}
                                        {{ucwords($production->unit_name) ?? ''}}
                                    </td>
                                </tr>
                            @endforeach
                        </table>
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                        <footer>
                            <div style="text-align: left;width: 50%;display: inline-block;float: left;padding-top: 30px;">
                                ------------------------------------------
                                <br/>
                                <strong>
                                        {{ucwords($production->employee->name) ?? ''}}
                                </strong>
                                <br/>
                                {{$production->employee->email ? 'Email: '.$production->employee->email  : ''}}
                                <br/>
                                {{$production->employee->contact_no ? 'Contact No: '.$production->employee->contact_no  : ''}}
                            </div>
                            <div style="text-align: right;width: 50%;display: inline-block;float: right;padding-top: 50px">
                                <img style="width: 50%;" src="data:image/png;base64,{{App\CustomClass\OwnLibrary::barcode_generator($production->id.'-'.$production->product_id, $production->barcode_symbology)}}" />
                                <div style="text-align: center;width: 50%;margin-left: auto;">
                                    {{$production->product->code}}
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </footer>
                        </div>
                        <div class="my-4 text-right">
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
            var divToPrint=document.getElementById('print-table');
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

