@extends("backend.master.main-layout")
@section("page-title","Product History")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title" style="margin-left: 45% !important;">Product History</h3>
                        <p style="margin-left: 95% !important;">
                            @if(!empty($aclList[32][7]))
                                <button id="print-btn" type="button" class="btn  btn-xs btn-primary"><i class="fas fa-print"></i></button>
                            @endif
                            @if(!empty($aclList[32][9]))
                                <a href="{{$reportUrl.'&action=csv'}}" class="btn btn-xs btn-success ledger-excel-hrf" title="Export to CSV" target="_blank"><i class="fas fa-file-excel"></i></a>
                            @endif
                        </p>
                    </div>

                    <div class="card-body">
                        <form method="get" action="{{route('product-history.get')}}">
                            @csrf
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group select2-parent">
                                        <label for="product">Product</label>
                                        <select name="product_ser" class="form-control search-product" style="width: 100%;" data-allow-clear="true" data-url="{{route('ser-product.get')}}">
                                            <option></option>
                                        </select>
                                        <input type="hidden" id="productProduceRoute" value="{{route('ser-product.get')}}">
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <div class="form-group" style="padding-top: 33px;">
                                        <button class="btn btn-dark " type="submit" id="search_btn">Search</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        {{--<div class="col-md-12 text-right"></div>--}}
                    </div>

                    @if(!empty($product_histories) && count($product_histories) > 0)
                    <div class="card-body table-responsive" id="prin-table">
                        <table class="table table-bordered production-table">
                            <thead>
                            <tr>
                                <th>SL</th>
                                <th>Date</th>
                                <th>Name</th>
                                <th>Code</th>
                                <th>Soruce</th>
                                <th>Quantity</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                                $in_stock = 0;
                                $qty = 0;
                                $sl = 1;
                                $action = '+';
                            ?>
                            @foreach($product_histories as $ph)
                                <tr>
                                    <td>{{ ++$sl }}</td>
                                    <td>{{ date("d/m/Y", strtotime($ph->date)) }}</td>
                                    <td>{{ $ph->name }}</td>
                                    <td>{{ $ph->code }}</td>
                                    <td>
                                        @if($ph->purchase_qty)
                                            {{ 'Order' }}
                                            <?php $in_stock += $ph->purchase_qty; $qty = $ph->purchase_qty; $action = '+'; ?>
                                        @elseif($ph->adjustment_qty)
                                            @if($ph->action == '+')
                                                {{ 'Adjustment (Addition)' }}
                                                <?php $in_stock += $ph->adjustment_qty; $qty = $ph->adjustment_qty; $action = '+'; ?>
                                            @else
                                                {{ 'Adjustment (Subtraction)' }}
                                                <?php $in_stock -= $ph->adjustment_qty; $qty = $ph->adjustment_qty; $action = '-'; ?>
                                            @endif
                                        @elseif($ph->production_qty)
                                            {{ 'Production' }}
                                            <?php $in_stock += $ph->production_qty; $qty = $ph->production_qty; $action = '+'; ?>
                                        @else
                                            {{ 'Use in production' }}
                                            <?php $in_stock -= $ph->production_use_qty; $qty = $ph->production_use_qty; $action = '-'; ?>
                                        @endif
                                    </td>
                                    @if($action == '+')
                                        <td class="text-right">{{ number_format($qty/$ph->unit_value, 2) }}</td>
                                    @else
                                        <td class="text-right">{{ '('. number_format($qty/$ph->unit_value, 2). ')' }}</td>
                                    @endif
                                </tr>
                            @endforeach
                            <tr>
                                <td colspan="5" class="text-right"><b>Total</b></td>
                                <td class="text-right"><b>{{ number_format($in_stock/$site_unit_val, 2) }}</b> {{$site_unit_name}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    @endif

                </div>

            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

@endsection

@section('js')
    <script type="text/javascript">
        $(document).ready(function () {

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
                    ' #count_pan {visibility: hidden}' +
                    ' .text-center {text-align: center !important}' +
                    ' .text-right {text-align: right !important}' +
                    '</style><body onload="window.print()">'+divToPrint.innerHTML+'</body>');
                newWin.document.close();
                setTimeout(function(){newWin.close();},10);
            });

        });
    </script>
@endsection
