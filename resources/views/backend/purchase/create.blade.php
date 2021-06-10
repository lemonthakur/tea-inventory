@extends("backend.master.main-layout")
@section("page-title","Add Purchase")
@section("main-content")
    <div class="content-wrapper">
        <!-- Main content -->
        <div class="content">
            <div class="container-fluid py-3">
                <div class="card">
                    <div class="card-header">
                        Add Purchase
                    </div>
                    <div class="card-body">
                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="warehouse">Warehouse<span class="text-red">*</span></label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Warehouse" data-allow-clear="true"
                                        id="warehouse" name="warehouse">
                                        <option></option>
                                        @foreach($warehouses as $warehouse)
                                            <option value="{{$warehouse->id}}">{{ucwords($warehouse->name)}}</option>
                                        @endforeach
                                    </select>

                                    <span class="text-danger">Validation Error</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="supplier">Supplier</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Supplier" data-allow-clear="true"
                                        id="supplier" name="supplier">
                                        <option></option>
                                        @foreach($suppliers as $supplier)
                                            <option value="{{$supplier->id}}">{{ucwords($supplier->name)}}</option>
                                        @endforeach
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="status">Purchase Status</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Status" data-allow-clear="true"
                                        id="status" name="status" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="1">Received</option>
                                        <option value="2">Partial</option>
                                        <option value="3">Pending</option>
                                        <option value="4">Ordered</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="file">
                                        Attach Document
                                        <i class="far fa-question-circle" data-toggle="tooltip" data-placement="top"
                                           title="Only jpg, jpeg, png, gif, pdf, csv, docx, xlsx and txt file is supported"></i>
                                    </label>
                                    <input id="file" type="file" class="form-control" name="file" />
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group select2-parent">
                                    <label for="employee">Select Product</label>
                                    <select name="employee" class="form-control live-search" id="live-search" style="width: 100%;">
                                        <option></option>
                                    </select>
                                    <span class="text-danger">Validation Error</span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <h5>Order Table *</h5>
                                <div class="table-responsive mt-3">
                                    <table id="order-table" class="table table-hover order-list">
                                        <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Code</th>
                                            <th>Quantity</th>
                                            <th class="recieved-product-qty d-none">Received</th>
                                            <th>Batch No</th>
                                            <th>Expired Date</th>
                                            <th>Net Unit Cost</th>
                                            <th>Discount</th>
                                            <th>Tax</th>
                                            <th>SubTotal</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>
                                                mango
                                            </td>
                                            <td>72782608</td>
                                            <td>
                                                <input type="number" class="form-control qty" name="qty[]" value="1" step="any" required="">
                                            </td>
                                            <td class="recieved-product-qty d-none">
                                                <input type="number" class="form-control recieved" name="recieved[]" value="1" step="any">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control batch-no" name="batch_no[]" disabled="">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control expired-date" name="expired_date[]" disabled="">
                                            </td>
                                            <td class="net_unit_cost">166.96</td>
                                            <td class="discount">0.00</td>
                                            <td class="tax">25.04</td>
                                            <td class="sub-total">192.00</td>
                                            <td style="width: 7%;">
                                               <div>
                                                   <button type="button" class="btn btn-warning btn-xs btn-edit" title="edit"
                                                           data-toggle="modal" data-target=".edit-product">
                                                       <i class="far fa-edit"></i>
                                                   </button>
                                                   <button type="button" class="btn btn-danger btn-xs btn-delete" title="delete">
                                                       <i class="far fa-trash-alt"></i>
                                                   </button>
                                               </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                        <tfoot class="tfoot active">
                                        <tr>
                                            <th colspan="2">Total</th>
                                            <th id="total-qty">2</th>
                                            <th class="recieved-product-qty d-none"></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th id="total-discount">0.00</th>
                                            <th id="total-tax">25.04</th>
                                            <th id="total">392.00</th>
                                            <th><i class="dripicons-trash"></i></th>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group select2-parent">
                                    <label for="order_tax_rate">Order Tax</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Tax" data-allow-clear="true"
                                        id="order_tax_rate" name="order_tax_rate" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="0">No Tax</option>
                                        <option value="10">vat@10</option>
                                        <option value="15">vat@15</option>
                                        <option value="20">vat 20</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="discount">Discount</label>
                                    <input id="discount" type="number" class="form-control" name="discount" />
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="shipping_cost">Shipping Cost</label>
                                    <input id="shipping_cost" type="number" class="form-control" name="shipping_cost" />
                                    <span class="text-danger"></span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="Note">Note</label>
                                    <textarea id="Note" class="form-control" name="Note"></textarea>
                                    <span class="text-danger"></span>
                                </div>
                            </div>
                            <div class="col-md-12 text-right">
                                <button type="button" class="btn btn-primary">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pt-3">
                        <table class="table table-bordered table-condensed totals">
                            <tbody><tr><td><strong>Items</strong>
                                    <span class="pull-right" id="item">0.00</span>
                                </td>
                                <td><strong>Total</strong>
                                    <span class="pull-right" id="subtotal">0.00</span>
                                </td>
                                <td><strong>Order Tax</strong>
                                    <span class="pull-right" id="order_tax">0.00</span>
                                </td>
                                <td><strong>Order Discount</strong>
                                    <span class="pull-right" id="order_discount">0.00</span>
                                </td>
                                <td><strong>Shipping Cost</strong>
                                    <span class="pull-right" id="shipping_cost">0.00</span>
                                </td>
                                <td><strong>Grand Total</strong>
                                    <span class="pull-right" id="grand_total">0.00</span>
                                </td>
                            </tr></tbody></table>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>

    <div class="modal fade edit-product" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"
         data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Product Name</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input type="number" name="edit_qty" class="form-control" step="any">
                                </div>
                            </div>
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Unit Discount</label>
                                   <input type="number" name="edit_discount" class="form-control" step="any">
                               </div>
                           </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Unit Cost</label>
                                    <input type="number" name="edit_unit_cost" class="form-control" step="any">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="order_tax_rate">Order Tax</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Tax" data-allow-clear="true"
                                        id="order_tax_rate" name="order_tax_rate" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="0">No Tax</option>
                                        <option value="10">vat@10</option>
                                        <option value="15">vat@15</option>
                                        <option value="20">vat 20</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group select2-parent">
                                    <label for="edit_unit">Product Unit</label>
                                    <select
                                        class="form-control single-select2"
                                        data-placeholder="Select Tax" data-allow-clear="true"
                                        id="edit_unit" name="edit_unit" data-minimum-results-for-search="Infinity">
                                        <option></option>
                                        <option value="0">cartoon box</option>
                                        <option value="1">Piece</option>
                                        <option value="2">dozen box</option>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Update</button>
                </div>
            </div>
        </div>
    </div>
    </div>
@endsection

@section('js')
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $('#live-search').select2({
                ajax: {
                    url: "{{route('employee.get')}}",
                    type:"POST",
                    dataType:"JSON",
                    data: function (params) {
                        return  query = {
                            search: params.term,
                            _token: "{{csrf_token()}}"
                        }
                    },

                    processResults: function (response) {
                        return {
                            results: response
                        };
                    },
                },
                placeholder: 'Search by employee name',
                minimumInputLength: 2,
            });
        });
        
        $(document).on('click','.btn-delete',function () {
            let deleteButton = $(this);
            deleteButton.closest('tr').remove();
        })
    </script>
@endsection
