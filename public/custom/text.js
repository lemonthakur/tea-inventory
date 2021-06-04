$(document).ready(function () {
    let textForm = $('#text_form');
    let textUrl = $('#text_url').val();
    // save text
    textForm.on('submit',function (event) {
        event.preventDefault();
        $.ajax({
            method:'POST',
            url:textUrl,
            data:textForm.serialize(),
            success:function (data) {
                console.log(data);
                if (data.status === 1){
                    textValidate(data)
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
                        $('#modal-text').modal('toggle');
                        location.reload();
                    })
                }
                // if unable to store data
                if (data.status === 3){
                    Swal.fire(data.data, "", "error");
                }
            }
        });
    });

    // edit text
    $('.edit-text').on('click',function () {
        let editUrl = $(this).attr('edit-url');
        $.ajax({
            type:'GET',
            url:editUrl,
            success:function (data) {
                $('#text_id').val(data.data.formField.id);
                $('#text').val(data.data.formField.form_text);
                $('#text_order').val(data.data.formField.order);
                $('#text_width').val(data.data.formField.field_width);
                $('#text_color').val(data.data.formField.field_label_color);
                $('#text_font_size').val(data.data.formField.field_label_font_size);

                // initialize color picker
                $('.color-picker').spectrum({
                    type: "text"
                });
            }
        });
        $('#modal-text').modal('toggle');
    });

    function textValidate(data){
        $.each(data.errors,function (key,value) {
            $('.'+key).closest('.form-group').find('.text-danger').text(value[0]);
            $('.'+key).addClass('is-invalid');
        })
    }
});
