@extends("backend.master.main-layout")
@section("page-title","Dashboard")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Dashboard</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        {{--                        <ol class="breadcrumb float-sm-right">--}}
                        {{--                            <li class="breadcrumb-item"><a href="#">Home</a></li>--}}
                        {{--                            <li class="breadcrumb-item active">Starter Page</li>--}}
                        {{--                        </ol>--}}
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 col-6">
                        <!-- small box -->
                        <div class="small-box bg-gradient-warning">
                            <div class="inner">
                                <h3>{{$formCount}}</h3>
                                <p>Number Of Form</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <a target="_blank" href="{{route('forms.index')}}" class="small-box-footer">View All <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-6 col-6">
                        <!-- small box -->
                        <div class="small-box bg-primary">
                            <div class="inner">
                                <h3>{{$formSubmitCount}}</h3>
                                <p>Form Sunmission</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-list-alt"></i>
                            </div>
                            <a target="_blank" href="{{route('form-submit.index')}}" class="small-box-footer">View All <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title text-center w-100 font-weight-bold">Latest Form Submission</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body p-0">
                                <div class="card-body table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead>
                                        <tr>
                                            <th>SL</th>
                                            <th>Form Name</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone Number</th>
                                            <th>Zip Code</th>
                                            <th>Receiver</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @forelse($formSubmits as $formSubmit)
                                            <tr>
                                                <td>{{$loop->iteration}}</td>
                                                <td>{{ucwords($formSubmit->form->form_title)}}</td>
                                                <td>{{ucwords($formSubmit->first_name)}} {{ucwords($formSubmit->last_name)}}</td>
                                                <td>{{ucwords($formSubmit->email)}}</td>
                                                <td>{{$formSubmit->phone_number}}</td>
                                                <td>{{$formSubmit->postal_code}}</td>
                                                <td>
                                                    <p><strong>Name</strong>: {{$formSubmit->receiver_name ?? ''}}</p>
                                                    <p><strong>Email</strong>: {{$formSubmit->receiver_email ?? ''}}</p>
                                                </td>
                                                <td class="text-center">
                                                    <a href="{{route('form-submit.show',$formSubmit->id)}}" class="btn btn-info btn-xs">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        @empty
                                            <tr>
                                                <td colspan="8" class="text-center">Nothing Found</td>
                                            </tr>
                                        @endforelse
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix">
                                <a href="{{route('form-submit.index')}}" class="btn btn-sm btn-secondary float-right">View All</a>
                            </div>
                            <!-- /.card-footer -->
                        </div>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection
