<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Form Submit</title>
    <!-- CSS only -->
    <style>
        body{
            background-color: whitesmoke;
            padding: 0;
            margin: 0;
        }
        .header{
            width: 90%;
            background-color: cornflowerblue;
            padding: 10px 0;
            color: white;
            margin: 5px auto 20px auto;
        }
        .header h3 {
            margin: 0;
            text-transform: capitalize;
            text-align: center;
        }
        table{
            width: 90%;
            margin: auto;
            border-collapse: collapse;
        }
        table,th,td{
            border: 1px solid gray;
        }
        table thead {
            background-color: #4152a7;
            color: #ffffff;
        }
        table tbody tr:nth-child(odd){
            background-color: lightgrey;
        }
        table tbody tr:nth-child(even){
            background-color: white;
        }
        th,td{
            padding: 3px 10px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="header">
    <h3>Product list with low quantity - {{date('d-m-Y H:i A')}}</h3>
</div>
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Code</th>
        <th>Unit</th>
        <th>Warehouse</th>
        <th>Qty</th>
        <th>Waste</th>
    </tr>
    </thead>
    <tbody>
    @foreach($products as $product)
        <tr>
            <td>{{ucwords($product->product->name)}}</td>
            <td>{{$product->product->code}}</td>
            <td>{{strtoupper($product->product->unit->name)}}</td>
            <td>{{ucwords($product->warehouse->name)}}</td>
            <td>{{$product->qty}}</td>
            <td>{{$product->waste_qty}}</td>
        </tr>
    @endforeach
    </tbody>
</table>
</body>
</html>

