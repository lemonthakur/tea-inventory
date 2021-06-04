<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="icon" href="{{$siteSetting->icon}}" type="image/gif">

    <title>@yield("page-title") | {{ucwords($siteSetting->site_title ?? 'APP_NAME')}} {{--{{env("APP_NAME")}}--}}</title>

    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/fontawesome-free/css/all.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/dist/css/adminlte.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/sweetalert2/sweetalert2.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/select2/css/select2.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/icheck-bootstrap/icheck-bootstrap.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/spectrum/dist/spectrum.min.css")}}">
    <link rel="stylesheet" href="{{asset("/public/admin-lte/plugins/datepicker/bootstrap-datepicker.min.css")}}">

    <link rel="stylesheet" href="{{asset("/public/custom/backend-custom.css")}}">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    @yield("css")

    {{------------------------------
    -----------Javascript-----------
    ------------------------------}}

    <script src="{{asset("/public/admin-lte/plugins/jquery/jquery.min.js")}}"></script>
    <script src="{{asset("/public/admin-lte/plugins/bootstrap/js/bootstrap.bundle.min.js")}}"></script>
    <script src="{{asset("/public/admin-lte/dist/js/adminlte.min.js")}}"></script>
    <script src="{{asset("/public/admin-lte/plugins/sweetalert2/sweetalert2.all.min.js")}}"></script>
    <script src="{{asset("/public/admin-lte/plugins/spectrum/dist/spectrum.min.js")}}"></script>
    <script src="{{asset("/public/admin-lte/plugins/datepicker/bootstrap-datepicker.min.js")}}"></script>

    {{------------------------------
    -----------Javascript-----------
    ------------------------------}}


</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <!-- Navbar -->
    @include("backend.include.top-navbar")
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    @include("backend.include.left-side-navbar")
    <!-- Main Sidebar Container -->

    @include("backend.include.errormsg")
    <!-- Content Wrapper. Contains page content -->
    @yield("main-content")
    <!-- /.content-wrapper -->

    <!-- Control Sidebar -->
    @include("backend.include.menu-responsive")
    <!-- /.control-sidebar -->

    <!-- Main Footer -->
    @include("backend.include.footer")
    <!-- Main Footer -->

</div>
<!-- ./wrapper -->

<script src="{{asset("public/admin-lte/plugins/select2/js/select2.full.min.js")}}"></script>
<script src="{{asset("/public/custom/backend-custom.js")}}"></script>
@yield("js")
</body>
</html>
