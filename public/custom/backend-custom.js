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

function tinymceInitial(){
    tinymce.init({
        selector: '.txt-editor',
        menubar: true,
        plugins: [
            "link image code fullscreen",
            'advlist autolink lists link charmap print preview hr anchor pagebreak',
            'searchreplace wordcount visualblocks visualchars code fullscreen',
            'insertdatetime media nonbreaking save table directionality',
            'emoticons template paste textpattern imagetools codesample toc'
        ],
        toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify |forecolor backcolor|bullist numlist outdent indent | link image',

        images_upload_url: 'postAcceptor.php',
        automatic_uploads: false,
        file_picker_types: 'file image media',
        image_caption: true,
        min_height: 300,
        max_height: 350,
        lineheight_formats: "8pt 9pt 10pt 11pt 12pt 14pt 16pt 18pt 20pt 22pt 24pt 26pt 36pt",
        importcss_append: true,
        fullpage_hide_in_source_view: true
    });
}

$('.search-product').select2({

    ajax: {
        url: $('.search-product').data('url'),
        type:"POST",
        dataType:"JSON",
        data: function (params) {
            return  query = {
                search: params.term,
                _token: $("input[name='_token']").val()
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

