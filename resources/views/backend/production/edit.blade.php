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
                                <th>Target Produce Amount</th>
                                <td>{{$production->targate_amount}}</td>
                                <th>Produce Amount</th>
                                <td>{{$production->produce_amount}}</td>
                            </tr>
                            <tr>
                                <th>Unit</th>
                                <td>{{$production->unit_name}}</td>
                                <th>Waste</th>
                                <td>{{$production->waste_amount}}</td>
                            </tr>
                            <tr>
                                <th>Warehouse</th>
                                <td>{{$production->warehouse->name ?? ''}}</td>
                                <th>Note</th>
                                <td>{{$production->note}}</td>
                            </tr>
                            <tr>
                                <th>Employee</th>
                                <td>{{ucwords($production->employee->name) ?? ''}}</td>
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
                                    <div class="col-md-12">
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

{{--                                    <div class="col-md-6">--}}
{{--                                        <div class="form-group select2-parent">--}}
{{--                                            <label for="status">Production Status<span class="text-red">*</span></label>--}}
{{--                                            <select--}}
{{--                                                class="form-control"--}}
{{--                                                data-placeholder="Select status"--}}
{{--                                                id="status" name="status">--}}
{{--                                                <option value="0">On Going</option>--}}
{{--                                                <option value="1">Finished</option>--}}
{{--                                            </select>--}}
{{--                                            <span class="text-danger"> {{$errors->has("status") ? $errors->first("status") : ""}} </span>--}}
{{--                                        </div>--}}
{{--                                    </div>--}}
                                    <div class="col-md-12">
                                        <h5>Employee *</h5>
                                        <div class="table-responsive mt-3">
                                            <table id="emloyee-table" class="table table-hover order-list" style="width: 100%;">
                                                <thead>
                                                <tr>
                                                    <th style="text-align: left;">Employee Name</th>
                                                    <th style="text-align: left;">Produce Amount</th>
                                                    <th style="text-align: left;">Waste Amount</th>
                                                    <th style=" text-align: center;">Action</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="vertical-align: middle;text-align: center">
                                                            <div class="form-group m-0">
                                                                <input required type="text" placeholder="Employee Name" class="form-control" name="employee_name[]" id="employee_name" min="0"/>
                                                                <span class="text-danger"></span>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align: middle;text-align: center">
                                                            <div class="form-group m-0">
                                                                <input required type="number" placeholder="Produce Amount" class="form-control" name="produce_amount[]" id="produce_amount" min="0"/>
                                                                <span class="text-danger"></span>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align: middle;text-align: center">
                                                            <div class="form-group m-0">
                                                                <input required type="number" placeholder="Waste Amount" class="form-control" name="waste_amount[]" id="waste_amount" min="0"/>
                                                                <span class="text-danger"></span>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align: middle;text-align: center">
{{--                                                            <button type="button" class="btn btn-danger btn-xs removeRow" title="Remove Row">--}}
{{--                                                                <i class="fas fa-trash"></i>--}}
{{--                                                            </button>--}}
{{--                                                            <span class="text-danger"></span>--}}
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                <tr>
                                                    <td colspan="4" class="text-right">
                                                        <button id="addRow" type="button" class="btn btn-info" title="Add Row">
                                                            <i class="fas fa-plus-square"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-12 text-right">
                                        <a href="{{route('production.index')}}"  class="btn btn-dark">Back</a>
                                        <button type="submit" id="nBtn" class="btn btn-info">Submit</button>
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

@section('js')
    <script>
        // $('#status').on('change',function () {
        //     let status = $(this).val();
        //     if (status == 1){
        //         Swal.fire({
        //             type: 'warning',
        //             title: 'Are you sure?',
        //             text: "You won't be able to modify any longer if you select finished and submit!",
        //             icon: 'warning',
        //             showCancelButton: false,
        //             confirmButtonText: 'Close!'
        //         });
        //     }
        // });
        $('#addRow').on('click',function () {
            $("#emloyee-table tbody").append('<tr>\n' +
                '                                                        <td style="vertical-align: middle;text-align: center">\n' +
                '                                                            <div class="form-group m-0">\n' +
                '                                                                <input required type="text" placeholder="Employee Name" class="form-control" name="employee_name[]" id="employee_name" min="0"/>\n' +
                '                                                                <span class="text-danger"></span>\n' +
                '                                                            </div>\n' +
                '                                                        </td>\n' +
                '                                                        <td style="vertical-align: middle;text-align: center">\n' +
                '                                                            <div class="form-group m-0">\n' +
                '                                                                <input required type="number" placeholder="Produce Amount" class="form-control" name="produce_amount[]" id="produce_amount" min="0"/>\n' +
                '                                                                <span class="text-danger"></span>\n' +
                '                                                            </div>\n' +
                '                                                        </td>\n' +
                '                                                        <td style="vertical-align: middle;text-align: center">\n' +
                '                                                            <div class="form-group m-0">\n' +
                '                                                                <input required type="number" placeholder="Waste Amount" class="form-control" name="waste_amount[]" id="waste_amount" min="0"/>\n' +
                '                                                                <span class="text-danger"></span>\n' +
                '                                                            </div>\n' +
                '                                                        </td>\n' +
                '                                                        <td style="vertical-align: middle;text-align: center">\n' +
                '                                                            <button type="button" class="btn btn-danger btn-xs removeRow" title="Remove Row">\n' +
                '                                                                <i class="fas fa-trash"></i>\n' +
                '                                                            </button>\n' +
                '                                                            <span class="text-danger"></span>\n' +
                '                                                        </td>\n' +
                '                                                    </tr>');
        });

        $(document).on("click",".removeRow",function () {
            let remove = $(this);
            remove.closest('tr').remove();
        })
    </script>
@endsection

