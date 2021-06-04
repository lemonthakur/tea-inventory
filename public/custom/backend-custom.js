// Cancel Button
$(".cancel").click(function () {
    history.back();
});

let fieldTypeList = {
    'text field':1,
    'email':2,
    'number':3,
    'textarea':4,
    'select':5,
    'radio':6,
    'checkbox':7,
    'file':8,
    'text':9,
}

// Delete Confirm
$(document).ready(function() {
    $('.delete').on('click', function (e) {
        e.preventDefault();
        var form = $(this).parents('form');
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            cancelButtonColor: '#d33',
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            showCancelButton: true,
        }).then((result) => {
            if (result.value) {
                form.submit();
            }
        });
    });
// datepicker
    $('.datepicker').datepicker({
        //format: 'yyyy/mm/dd',
        format: 'dd-mm-yyyy',
        autoclose:true,
        clearBtn:true,
        todayHighlight:true,
    });

});

// Minimal Select 2
$(document).ready(function() {
    $('.single-select2').select2();
});

// Image Upload
$(document).ready(function() {
    $('.image').change(function () {
        var image = document.getElementById('output');
        image.src = URL.createObjectURL(event.target.files[0]);
    });

    // Logo Upload
    $(document).ready(function() {
        $('.logo').change(function () {
            var logo = document.getElementById('outputLogo');
            logo.src = URL.createObjectURL(event.target.files[0]);
        });
    });

    $('.color-picker').spectrum({
        type: "text"
    });
});
