$(document).ready(function () {
    // edit modal field show
    $('.edit').on('click',function () {
        let editUrl = $(this).attr('edit-url');
        $('#edit-option-holder').empty();
        $('#edit-dynamic-field').css('display','none');
        $('#edit_field_type').attr('disabled',false);
        $.ajax({
            type:'GET',
            url:editUrl,
            success:function (data) {
                console.log(fieldTypeList[data.data.formField.field_type]);
                $('#fieldId').val(data.data.formField.id);
                $('#edit_field_name').val(data.data.formField.field_name);
                $('#edit_order').val(data.data.formField.order);
                $('#edit_field_width').val(data.data.formField.field_width);
                $('#edit_field_placeholder').val(data.data.formField.field_placeholder);
                $("input[name=is_show_field_label]").val([data.data.formField.is_show_field_label]);
                $('#edit_field_label_color').val(data.data.formField.field_label_color);
                $('#edit_field_label_font_size').val(data.data.formField.field_label_font_size);
                $('#edit_field_background_color').val(data.data.formField.field_background_color);
                $('#edit_field_font_color').val(data.data.formField.field_font_color);
                $('#edit_field_font_size').val(data.data.formField.field_font_size);
                $('#edit_field_border_color').val(data.data.formField.field_border_color);
                $("input[name=is_required]").val([data.data.formField.is_required]);
                $('#edit_field_type').val(fieldTypeList[data.data.formField.field_type]);

                if (data.data.formField.is_fixed == 1){
                    $('#edit_field_type').attr('disabled',true);
                }

                if (fieldTypeList[data.data.formField.field_type]>=5 && fieldTypeList[data.data.formField.field_type]<=7){
                    $('#edit-dynamic-field').css('display','block');
                    if (data.data.fieldOption.length > 0){
                        $.each(data.data.fieldOption,function (key,value) {
                            $('#edit-option-holder').append('<div class="row">\n' +
                                '                                    <div class="col-md-5">\n' +
                                '                                        <div class="form-group">\n' +
                                '                                            <label for="option_text">Option Text<span>*</span></label>\n' +
                                '                                            <input type="text"\n' +
                                '                                                   class="form-control edit_option_text"\n' +
                                '                                                   name="option_text[]" placeholder="Enter Option Text" value="'+value['option_text']+'">\n' +
                                '                                            <span class="text-danger"></span>\n' +
                                '                                        </div>\n' +
                                '                                    </div>\n' +
                                '                                    <div class="col-md-5">\n' +
                                '                                        <div class="form-group">\n' +
                                '                                            <label for="option_value">Optoin Value<span>*</span></label>\n' +
                                '                                            <input type="text"\n' +
                                '                                                   class="form-control edit_option_value"\n' +
                                '                                                   name="option_value[]" placeholder="Enter Option Value" value="'+value['option_value']+'">\n' +
                                '                                            <span class="text-danger"></span>\n' +
                                '                                        </div>\n' +
                                '                                    </div>\n' +
                                '                                    <div class="d-none">\n' +
                                '                                        <div class="form-group">\n' +
                                '                                            <input type="text"\n' +
                                '                                                   class="form-control option_id"\n' +
                                '                                                   name="option_id[]" value="'+value['id']+'">\n' +
                                '                                        </div>\n' +
                                '                                    </div>\n' +
                                '                                    <div class="col-md-2">\n' +
                                '                                        <div class="form-group text-right">\n' +
                                '                                            <div class="form-group pt-4 mt-2 text-right">\n' +
                                '                                                <button type="button" class="btn btn-danger edit-delete-option" optionId="'+value['id']+'">Remove</button>\n' +
                                '                                            </div>\n' +
                                '                                        </div>\n' +
                                '                                    </div>\n' +
                                '                                </div>');
                        });
                    }else{
                       addOption();
                    }
                }

                // initialize color picker
                $('.color-picker').spectrum({
                    type: "text"
                });
            }
        });
        $('#modal-edit-field').modal('toggle');
    });

    $(document).on('click','.edit-delete-option',function () {
        let button = $(this);
        let id = button.attr('optionId');
        let editUrl = $('#option-delete-url').val() + id;
        let token = $("input[name=_token]").val();
        $.ajax({
            method:'POST',
            url:editUrl,
            data: {_token:token},
            success:function (data) {
                if (data.status === 1){
                    button.closest('.row').remove();
                }else{
                    swal.fire('Unable to delete','','error');
                }
            }
        });
    });

    // bring option field based on field type when edit
    $('#edit_field_type').on('change',function () {
        let type = $('#edit_field_type').val();
        if (type >=5 && type <=7 ){
            $('#edit-dynamic-field').css('display','block');
            addOption();
        }else{
            $('#edit-dynamic-field').css('display','none');
        }
    });

    // edit option field
    $('#edit-add-option').on('click',function () {
        addOption();
    });

    // remove optopn field from edit
    $(document).on('click','.edit-remove-option',function () {
        $(this).closest('.row').remove();
    });

    // add option text to option value as slug in edit model
    $(document).on('input','.edit_option_text',function () {
        let text = convertToSlug2($(this).val());
        $(this).closest('.row').find('.edit_option_value').val(text);
    });
    // make slug of option text
    function convertToSlug2(Text)
    {
        return Text
            .toLowerCase()
            .replace(/[^\w ]+/g,'')
            .replace(/ +/g,'-')
            ;
    }

    // edit field form submit
    $('#edit-field-form').submit(function (event) {
        event.preventDefault();
        $('.form-control').removeClass('is-invalid');
        $('.text-danger').text('');
        $('.option_text').closest('.form-group').find('.text-danger').text('');
        $('.option_text').removeClass('is-invalid');
        $.ajax({
            type:'PUT',
            url:$('#edit-url').val()+$('#fieldId').val(),
            data: $('#edit-field-form').serialize(),
            success:function (data) {
                if (data.status === 1){
                    editValidate(data)
                }
                // if operation success
                if (data.status === 2){
                    Swal.fire({
                        title: data.data,
                        showDenyButton: false,
                        showCancelButton: false,
                        confirmButtonText: `ok`,
                        denyButtonText: ``,
                    }).then((result) => {
                        $('#modal-add-field').modal('toggle');
                        location.reload();
                    })
                }
                // if unable to store data
                if (data.status === 3){
                    Swal.fire(data.data, "", "error");
                }
                // if field type is select,radio or checkbox and option value is not provided
                if (data.status === 4){
                    $('.edit_option_text').closest('.form-group').find('.text-danger').text('Add option text');
                    $('.edit_option_text').addClass('is-invalid');
                }

            }
        });
    });

    // edit show validation message
    function editValidate(data){
        $.each(data.errors,function (key,value) {
            $('#edit_'+key).closest('.form-group').find('.text-danger').text(value[0]);
            $('#edit_'+key).addClass('is-invalid');
        })
    }

    function addOption(){
        $('#edit-option-holder').append('' +
            '<div class="row">\n' +
            '                                <div class="col-md-5">\n' +
            '                                    <div class="form-group">\n' +
            '                                        <label for="option_text">Optoin Text<span>*</span></label>\n' +
            '                                        <input type="text" class="form-control edit_option_text" name="option_text[]" placeholder="Enter Option Text">\n' +
            '                                        <span class="text-danger"></span>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                                <div class="col-md-5">\n' +
            '                                    <div class="form-group">\n' +
            '                                        <label for="option_value">Optoin Value<span>*</span></label>\n' +
            '                                        <input type="text" class="form-control edit_option_value" name="option_value[]" placeholder="Enter Option Value">\n' +
            '                                        <span class="text-danger"></span>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                                <div class="col-md-2">\n' +
            '                                    <div class="form-group pt-4 mt-2 text-right">\n' +
            '                                        <button type="button" class="btn btn-danger edit-remove-option">Remove</button>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                            </div>');
    }
});
