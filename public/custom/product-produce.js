//get product for production list
$('#product-produce').select2({
    ajax: {
        url: $('#productProduceRoute').val(),
        type:"POST",
        dataType:"JSON",
        data: function (params) {
            return  query = {
                search: params.term,
                _token: $('#csrfToken').val()
            }
        },
        processResults: function (response) {
            return {
                results: response
            };
        },

    },
    placeholder: 'Search by product name or product code',
    minimumInputLength: 2,
});

// check warehouse selected or not
$(document).on('select2:open', 'select.live-search', function (e) {
    var nWarehouseId = $('#nWarehouseId').val();
    if(!nWarehouseId){
        $('#nproductId').val(null).trigger('change.select2');
        alert('Please select Warehouse!');
        $(this).select2('close');
    }
});

// get product necessary product need to produce
$('#nproductId').select2({
    ajax: {
        url: $('#productNeedRoute').val(),
        type:"POST",
        dataType:"JSON",
        data: function (params) {
            return  query = {
                search: params.term,
                warehouse_id: $("#nWarehouseId").val(),
                _token: $('#csrfToken').val()
            }
        },

        processResults: function (response) {
            return {
                results: response
            };
        },

    },
    placeholder: 'Search by product name or product code',
    minimumInputLength: 2,
});

$('#nBtn').on('click',function () {
    var nWarehouseId = $('#nWarehouseId').val();
    var nproductId = $('#nproductId').val();
    var nQty = $('#nQty').val();
    var _token =$('#csrfToken').val()

    // if (!nWarehouseId || !nproductId || !nQty){
    //     alert('Please provide all required field value ');
    //     return ;
    // }

    $('#nproductId').val(null).trigger('change.select2');
    $('#nWarehouseId').val(null).trigger('change.select2');
    $('#nQty').val('');

    $('#nproductId').closest('.form-group').find('.text-danger').text('');
    $('#nWarehouseId').closest('.form-group').find('.text-danger').text('');
    $('#nQty').closest('.form-group').find('.text-danger').text('');

    $.ajax({
        type:'post',
        url:$('#addTocart').val(),
        data: {nWarehouseId,nproductId,nQty,_token},
        success:function (data) {
            if (data.status === 1){
                validate(data)
            }

            if (data.status === 2){
                Swal.fire(
                    '',
                    data.data,
                    'error'
                )
            }

            if (data.status === 3){
                $('#order-table tbody').empty();
                $.each(data.data,function (index,value) {
                   $('#order-table tbody').append('  <tr>\n' +
                       '                                                    <td>'+value.name+'</td>\n' +
                       '                                                    <td>'+value.options.productCode+'</td>\n' +
                       '                                                    <td>'+value.options.unit+'</td>\n' +
                       '                                                    <td>'+value.options.warehouseName+'</td>\n' +
                       '                                                    <td>'+value.qty+'</td>\n' +
                       '                                                    <td class="text-center">\n' +
                       '                                                        <button rowId="'+value.rowId+'" type="button" class="btn btn-danger btn-xs removeCart">\n' +
                       '                                                            <i class="fas fa-trash"></i>\n' +
                       '                                                        </button>\n' +
                       '                                                    </td>\n' +
                       '                                                </tr>');
                })
            }
        }
    });
});

$(document).on('click','.removeCart',function () {
    var selectBtn = $(this);
    var rowId = selectBtn.attr('rowId');
    var _token =$('#csrfToken').val()
    $.ajax({
        type:'post',
        url:$('#removeCart').val(),
        data: {rowId,_token},
        success:function (data) {
            if (data.status === 3){
                $('#order-table tbody').empty();
                $.each(data.data,function (index,value) {
                    $('#order-table tbody').append('  <tr>\n' +
                        '                                                    <td>'+value.name+'</td>\n' +
                        '                                                    <td>'+value.options.productCode+'</td>\n' +
                        '                                                    <td>'+value.options.unit+'</td>\n' +
                        '                                                    <td>'+value.options.warehouseName+'</td>\n' +
                        '                                                    <td>'+value.qty+'</td>\n' +
                        '                                                    <td class="text-center">\n' +
                        '                                                       <button rowId="'+value.rowId+'" type="button" class="btn btn-danger btn-xs removeCart">\n' +
                        '                                                            <i class="fas fa-trash"></i>\n' +
                        '                                                        </button>\n' +
                        '                                                    </td>\n' +
                        '                                                </tr>');
                })
            }
        }
    });
})

// add show validation message
function validate(data){
    $.each(data.errors,function (key,value) {
        $('#'+key).closest('.form-group').find('.text-danger').text(value[0]);
        // $('#'+key).addClass('is-invalid');
    })
}

