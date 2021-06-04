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
        }
        table{
            width: 90%;
            margin: auto;
            border-collapse: collapse;
        }
        table,th,td{
            border: 1px solid gray;
        }
        th,td{
            padding: 3px 2px;
        }
    </style>
</head>
<body>
<table>
    <tbody>
    <tr style="text-align: center;">
        <th colspan="4">
            <h3>{{ucwords($formSubmit->form->form_title)}}</h3>
        </th>
    </tr>
    <tr>
        <th>First Name</th>
        <td>{{$formSubmit->first_name}}</td>
        <th>Last Name</th>
        <td>{{$formSubmit->last_name}}</td>
    </tr>
    <tr>
        <th>Email</th>
        <td>{{$formSubmit->email}}</td>
        <th>Phone</th>
        <td>{{$formSubmit->phone_number}}</td>
    </tr>
    <tr>
        <th>Zip Code</th>
        <td>{{$formSubmit->postal_code}}</td>
        <th>Receiver</th>
        <td>
            <p><strong>Name</strong>: {{$formSubmit->receiver_name ?? ''}}</p>
            <p><strong>Email</strong>: {{$formSubmit->receiver_email ?? ''}}</p>
        </td>
    </tr>
    @foreach($formSubmit->formSubmitValue->chunk(2) as $values)
        <tr>
            @foreach($values as $value)
                @if($value->field_type == "checkbox")
                    <th>{{ucwords($value->field_name)}}</th>
                    <td>{{ucwords(implode(', ',json_decode($value->value)))}}</td>
                @elseif($value->field_type == "file")
                    <th>{{ucwords($value->field_name)}}</th>
                    <td width="35%">
                        <div class="row">
                            @foreach(json_decode($value->value) as $file)
                                @if($file->ext == 'jpg' || $file->ext == 'jpeg' || $file->ext == 'png' || $file->ext == 'gif')
                                    <div style="width: 30%; margin-right: 3px;display: inline-block;text-align: center;">
                                        <a target="_blank" href="{{asset($file->url)}}">
                                            <img width="100%" src="{{asset($file->url)}}" alt="{{$value->field_name.' image'}}">
                                        </a>
                                    </div>
                                @else
                                    <div style="width: 30%; margin-right: 3px;display: inline-block;text-align: center">
                                        <a class="btn btn-warning btn-xs" download href="{{asset($file->url)}}">Download</a>
                                    </div>
                                @endif
                            @endforeach
                        </div>
                    </td>
                @else
                    <th>{{ucwords($value->field_name)}}</th>
                    <td>{{ucwords($value->value)}}</td>
                @endif

                @if(count($values) < 2)
                    <th></th>
                    <td></td>
                @endif

            @endforeach
        </tr>
    @endforeach
    </tbody>
</table>
</body>
</html>

