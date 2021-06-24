@extends("backend.master.main-layout")
@section("page-title","Mail Receiver")
@section("main-content")
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Mail Receiver</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            {{--<li class="breadcrumb-item"><a href="#">Home</a></li>--}}
                            {{--<li class="breadcrumb-item active">Starter Page</li>--}}
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Mail Receiver List</h3>
                                @if(!empty($aclList[24][2]))
                                    <button type="button" class="btn btn-primary float-right text-white" data-toggle="modal" data-target="#addReceiver">
                                    <i class="fas fa-plus-circle"></i>
                                    Add
                                    </button>
                                    @endif
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body table-responsive">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Contact No</th>
                                        <th>Designation</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse($receivers as $receiver)
                                        <tr>
                                            <td>{{$loop->iteration}}</td>
                                            <td>{{ ucwords($receiver->user->name) }}</td>
                                            <td>{{ $receiver->user->email ?? '' }}</td>
                                            <td>{{$receiver->user->contact_no ?? ''}}</td>
                                            <td>{{$receiver->user->role->name ?? ''}}</td>
                                            <td class="text-center">
                                                    <form method="post" action="{{ route('email-receiver.destroy',$receiver->id) }}">
                                                        @if(!empty($aclList[24][4]))
                                                            @method('delete')
                                                            @csrf
                                                            <button type="submit" class="btn btn-xs btn-danger text-white delete" title="Delete">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                        @endif
                                                    </form>
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
                            <!-- /.card-body -->
                            <div class="card-footer clearfix text-right">
                                {{$receivers->links("backend.include.pagination")}}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->

        <!-- Modal -->
        <div class="modal fade" id="addReceiver" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Email Receiver</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="post" action="{{route('email-receiver.store')}}">
                        @csrf
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group select2-parent">
                                    <label for="employeeIds">Employee</label>
                                    <select
                                        class="form-control single-select2 {{$errors->has("employeeIds") ? "is-invalid":""}}"
                                        data-placeholder="Select Employee" data-allow-clear="true"
                                        id="employeeIds" name="employeeIds[]" multiple>
                                        <option></option>
                                        @foreach($users as $user)
                                            @if(!empty(old('employeeIds')))
                                                <option {{ in_array($user->id,old('employeeIds')) ? 'selected' : ''}} value="{{$user->id}}">{{ucwords($user->name).'->'.ucwords($user->role->name)}}</option>
                                            @else
                                                <option value="{{$user->id}}">{{ucwords($user->name).'->'.ucwords($user->role->name)}}</option>
                                            @endif
                                        @endforeach
                                    </select>

                                    <span
                                        class="text-danger"> {{$errors->has("employeeIds") ? $errors->first("employeeIds") : ""}} </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
@endsection

@section('js')
    @if($errors->has("employeeIds"))
    <script>
            $('#addReceiver').modal('show');
    </script>
    @endif
@endsection
