@extends("backend.master.main-layout")
@section("page-title","Production-Show")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-body">
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
                        </table>
                        <div class="my-3 p-3" style="background-color: lightgrey">
                            <h5 class="text-center m-0 mb-2">Finished Production</h5>
                            <form method="post" action="{{route('production.update',$production->id)}}">
                                @csrf
                                @method('Put')
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group select2-parent">
                                            <label for="warehouse">Warehouse<span class="text-red">*</span></label>
                                            <select
                                                class="form-control single-select2"
                                                data-placeholder="Select Warehouse" data-allow-clear="true"
                                                id="warehouse" name="warehouse">
                                                <option></option>
                                                @foreach($warehouses as $warehouse)
                                                    <option @if(old('$warehouses') == $warehouse->id) selected @endif value="{{$warehouse->id}}">{{ucwords($warehouse->name)}}</option>
                                                @endforeach
                                            </select>
                                            <span class="text-danger"> {{$errors->has("warehouse") ? $errors->first("warehouse") : ""}} </span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="produce_amount">Produce Amount<span class="text-red">*</span></label>
                                            <input type="number" step="any" class="form-control" id="produce_amount" min="0" name="produce_amount" value="{{old('produce_amount')}}"/>
                                            <span class="text-danger"> {{$errors->has("produce_amount") ? $errors->first("produce_amount") : ""}} </span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="waste_amount">Waste Amount<span class="text-red">*</span></label>
                                            <input type="number" step="any" class="form-control" name="waste_amount" id="waste_amount" min="0" value="{{old('waste_amount')}}" />
                                            <span class="text-danger"> {{$errors->has("waste_amount") ? $errors->first("waste_amount") : ""}} </span>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-right">
                                        <button type="submit" style="margin-top: 20%;" id="nBtn" class="btn btn-info">Finished</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
@endsection

