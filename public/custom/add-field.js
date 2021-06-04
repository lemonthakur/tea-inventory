$(document).ready(function () {

    // bring opton field based on field type
    $('#field_type').on('change',function () {
        let type = $('#field_type').val();
        if (type >=5 && type <=7 ){
            $('#dynamic-field').css('display','block');
        }else{
            $('#dynamic-field').css('display','none');
        }
    });

    // add option field
    $('#add-option').on('click',function () {
        $('#option-holder').append('' +
            '<div class="row">\n' +
            '                                <div class="col-md-5">\n' +
            '                                    <div class="form-group">\n' +
            '                                        <label for="option_text">Optoin Text<span>*</span></label>\n' +
            '                                        <input type="text" class="form-control option_text" name="option_text[]" placeholder="Enter Option Text">\n' +
            '                                        <span class="text-danger"></span>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                                <div class="col-md-5">\n' +
            '                                    <div class="form-group">\n' +
            '                                        <label for="option_value">Optoin Value<span>*</span></label>\n' +
            '                                        <input type="text" class="form-control option_value" name="option_value[]" placeholder="Enter Option Value">\n' +
            '                                        <span class="text-danger"></span>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                                <div class="col-md-2">\n' +
            '                                    <div class="form-group pt-4 mt-2 text-right">\n' +
            '                                        <button type="button" class="btn btn-danger remove-option">Remove</button>\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                            </div>');
    });

    // remove optopn field
    $(document).on('click','.remove-option',function () {
        $(this).closest('.row').remove();
    });

    // add option text to option value as slug
    $(document).on('input','.option_text',function () {
        let text = convertToSlug($(this).val());
        $(this).closest('.row').find('.option_value').val(text);
    });

    // make slug of option text
    function convertToSlug(Text)
    {
        return Text
            .toLowerCase()
            .replace(/[^\w ]+/g,'')
            .replace(/ +/g,'-')
            ;
    }
    // add field form submit
    $('#add-field-form').submit(function (event) {
        event.preventDefault();
        $('.form-control').removeClass('is-invalid');
        $('.text-danger').text('');
        $('.option_text').closest('.form-group').find('.text-danger').text('');
        $('.option_text').removeClass('is-invalid');
        $.ajax({
            type:'POST',
            url:$('#add-url').val(),
            data: $('#add-field-form').serialize(),
            success:function (data) {
                //validation check
                if (data.status === 1){
                    validate(data)
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
                    $('.option_text').closest('.form-group').find('.text-danger').text('Add option text');
                    $('.option_text').addClass('is-invalid');
                }

            }
        });
    });

    // add show validation message
    function validate(data){
        $.each(data.errors,function (key,value) {
            $('#'+key).closest('.form-group').find('.text-danger').text(value[0]);
            $('#'+key).addClass('is-invalid');
        })
    }
});
