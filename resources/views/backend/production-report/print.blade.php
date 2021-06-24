<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{{'low quantity product-'.date('d/m/Y H:i a')}}</title>
</head>
<body>
<?php
$page = \Request::get('page');
$page = empty($page) ? 1 : $page;
$sl = ($page-1)*20;
$l = 1;
?>
<div class="card-body table-responsive" id="prin-table">
    <table class="table table-bordered production-table">
        <thead>
        <tr>
            <th>SL</th>
            <th>Product Name</th>
            <th>Qty</th>
            <th>Unit</th>
            <th>Warehouse</th>
        </tr>
        </thead>
        <tbody>
        @forelse($products as $product)
            <tr>
                <td>{{ ++$sl }}</td>
                <td>{{ ucwords($product->product_name) }}</td>
                <td class="text-right">{{ number_format($product->product_warehouse_qty, 2) }}</td>
                <td>{{ $product->unit_name }}</td>
                <td>{{ ucwords($product->warehouse_name) }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="11" class="text-center">Nothing Found</td>
            </tr>
        @endforelse

        </tbody>
    </table>
</div>
<script type="text/javascript">
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
</script>
</body>
</html>
