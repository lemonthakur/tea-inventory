"use strict"
$(document).ready(function () {

    const url = $('#form-url').val();
    $('#saving').hide();
    $('#message-holder').fadeOut();

    $('#form').submit(function (event) {
        event.preventDefault();
        $('#save').hide();
        $('#saving').show();
        $('.form-control').removeClass('is-invalid');
        $('.text-danger').text('');
        $.ajax({
            method:'POST',
            url:url,
            // dataType: "JSON",
            data: new FormData(this),
            processData: false,
            contentType: false,
            success:function (data) {
                $('#save').show();
                $('#saving').hide();

                // Form Not Found
                if (data.status === 1 || data.status === 4){
                    $('#message-holder').removeClass('bg-success').addClass('bg-danger').text(data.msg).fadeIn(1500).delay(3000).fadeOut(1500);
                }
                //validation check
                if (data.status === 2){
                    validate(data)
                }

                if (data.status === 3){
                    $('#message-holder').removeClass('bg-danger').addClass('bg-success').text(data.msg).fadeIn(1500).delay(3000).fadeOut(1500);
                    $('#form').trigger("reset");
                }
            }
        });
    });

    // show validation message
    function validate(data){
        $.each(data.errors,function (key,value) {
            $('#'+key).closest('.form-group').find('.text-danger').text(value[0]);
            $('#'+key).addClass('is-invalid');
        })
    }

});
