<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="{{route('dashboard')}}" class="brand-link">
        @if(!$siteSetting->logo)
        <img src="{{asset("/public/admin-lte/dist/img/AdminLTELogo.png")}}" alt="Company Logo"
             class="brand-image img-circle elevation-3"
             style="opacity: .8">
        @else
            <img src="{{asset($siteSetting->logo)}}" alt="Company Logo"
                 class="brand-image img-circle elevation-3"
                 style="opacity: .8">
        @endif
        <span class="brand-text font-weight-light">{{ucwords($siteSetting->site_title ?? '')}}</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                @auth
                    @if(auth()->user()->photo)
                        <img src="{{asset(auth()->user()->photo)}}" class="img-circle elevation-2" alt="User Image">
                    @else
                        <img src="{{asset("/public/demo-pic/profile.png")}}" class="img-circle elevation-2"
                             alt="User Image">
                    @endif
                @elseauth
                    <img src="{{asset("/public/demo-pic/profile.png")}}" class="img-circle elevation-2"
                         alt="User Image">
                @endauth
            </div>
            <div class="info">
                @auth
                    <a href="#" class="d-block">{{auth()->user()->name}}</a>
                @endauth
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <li class="nav-item">
                    <a href="{{route('dashboard')}}" class="nav-link">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            Dashboard
                        </p>
                    </a>
                </li>

                @if(!empty($aclList[6][1]) || !empty($aclList[10][1]) || !empty($aclList[10][2]))
                    <li class="nav-item has-treeview {{ ($routeName == 'user.index' || $routeName == 'user.create' || $routeName == 'user.edit' || $routeName == 'employees.index' || $routeName == 'employees.create' || $routeName == 'employees.edit') ? 'menu-open' : '' }}">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-user"></i>
                            <p>
                                User Management
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            @if(!empty($aclList[6][1]))
{{--                            <li class="nav-item">--}}
{{--                                <a href="{{route("user.index")}}"--}}
{{--                                   class="nav-link {{ ($routeName == 'user.index' || $routeName == 'user.create'|| $routeName == 'user.edit') ? 'active' : '' }}">--}}
{{--                                    <i class="far fa-circle nav-icon"></i>--}}
{{--                                    <p>Admin Panel User</p>--}}
{{--                                </a>--}}
{{--                            </li>--}}
                            @endif
                            @if(!empty($aclList[10][1]))
                            <li class="nav-item">
                                <a href="{{route("employees.index")}}"
                                   class="nav-link {{ ($routeName == 'employees.index') ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Employee List</p>
                                </a>
                            </li>
                                @endif
                                @if(!empty($aclList[10][2]))
                            <li class="nav-item">
                                <a href="{{route("employees.create")}}"
                                   class="nav-link {{ ($routeName == 'employees.create') ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Employee Create</p>
                                </a>
                            </li>
                                    @endif
                        </ul>
                    </li>
                @endif

                @if(!empty($aclList[1][1]) || !empty($aclList[2][1]) || !empty($aclList[3][1]))
                <li class="nav-item has-treeview {{ ($routeName == 'role.index' || $routeName == 'role.create' || $routeName == 'role.edit' || $routeName == 'role.access' || $routeName == 'user.access') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-universal-access"></i>
                        <p>
                            Access Control
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[1][1]))
                        <li class="nav-item">
                            <a href="{{route("role.index")}}"
                               class="nav-link {{ ($routeName == 'role.index' || $routeName == 'role.create'|| $routeName == 'role.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Designation Management</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[2][1]))
                        <li class="nav-item">
                            <a href="{{route("role.access")}}"
                               class="nav-link {{ ($routeName == 'role.access') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Designation Access Control</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[3][1]))
                        <li class="nav-item">
                            <a href="{{route("user.access")}}"
                               class="nav-link {{ ($routeName == 'user.access') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>User Access Control</p>
                            </a>
                        </li>
                                @endif

                    </ul>
                </li>
                @endif

                @if(!empty($aclList[11][1]) || !empty($aclList[11][2]) || !empty($aclList[12][1]) || !empty($aclList[12][2])
                || !empty($aclList[13][1]) || !empty($aclList[13][2]) || !empty($aclList[14][7]))
                <li class="nav-item has-treeview {{ ($routeName == 'categories.index' || $routeName == 'categories.create'
                 || $routeName == 'categories.edit' || $routeName == 'product.index' || $routeName == 'product.create'
                || $routeName == 'product.edit' || $routeName == 'product.printBarcode' || $routeName == 'qty_adjustment.index' || $routeName == 'qty_adjustment.create' || $routeName == 'qty_adjustment.edit') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Product
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[11][1]))
                            <li class="nav-item">
                                <a href="{{route("categories.index")}}"
                                   class="nav-link {{ ($routeName == 'categories.index') ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Category List</p>
                                </a>
                            </li>
                        @endif
                            @if(!empty($aclList[11][2]))
                        <li class="nav-item">
                            <a href="{{route("categories.create")}}"
                               class="nav-link {{ ($routeName == 'categories.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Category Create</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[12][1]))
                        <li class="nav-item">
                            <a href="{{route("product.index")}}"
                               class="nav-link {{ ($routeName == 'product.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Product List</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[12][1]))
                        <li class="nav-item">
                            <a href="{{route("product.create")}}"
                               class="nav-link {{ ($routeName == 'product.create' || $routeName == 'product.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Product Create</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[13][1]))
                        <li class="nav-item">
                            <a href="{{route("qty_adjustment.index")}}"
                               class="nav-link {{ ($routeName == 'qty_adjustment.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Adjustment List</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[13][2]))
                        <li class="nav-item">
                            <a href="{{route("qty_adjustment.create")}}"
                               class="nav-link {{ ($routeName == 'qty_adjustment.create' || $routeName == 'qty_adjustment.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Adjustment Create</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[14][7]))
                        <li class="nav-item">
                            <a href="{{route("product.printBarcode")}}"
                               class="nav-link {{ ($routeName == 'product.printBarcode') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Print Barcode</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
                @endif

                @if(!empty($aclList[15][1]) || !empty($aclList[15][2]))
                <li class="nav-item has-treeview {{ ($routeName == 'order.index' || $routeName == 'order.create' ||
                $routeName == 'order.edit' || $routeName == 'order.label') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                           Order
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[15][1]))
                        <li class="nav-item">
                            <a href="{{route("order.index")}}"
                               class="nav-link {{ ($routeName == 'order.index' || $routeName == 'order.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Order List</p>
                            </a>
                        </li>
                        @endif
                        @if(!empty($aclList[15][2]))
                        <li class="nav-item">
                            <a href="{{route("order.create")}}"
                               class="nav-link {{ ($routeName == 'order.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Order</p>
                            </a>
                        </li>
                            @endif
                    </ul>
                </li>
                @endif

                @if(!empty($aclList[16][1]) || !empty($aclList[16][2]) || !empty($aclList[17][1]))
                <li class="nav-item has-treeview {{ ($routeName == 'transfer.index' || $routeName == 'transfer.create' ||
                $routeName == 'transfer.edit' || $routeName == 'transfer-received.index') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Transfer
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[16][1]))
                        <li class="nav-item">
                            <a href="{{route("transfer.index")}}"
                               class="nav-link {{ ($routeName == 'transfer.index' || $routeName == 'transfer.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Transfer List</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[16][2]))
                        <li class="nav-item">
                            <a href="{{route("transfer.create")}}"
                               class="nav-link {{ ($routeName == 'transfer.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Transfer</p>
                            </a>
                        </li>
                            @endif
                            @if(!empty($aclList[17][1]))
                        <li class="nav-item">
                            <a href="{{route("transfer-received.index")}}"
                               class="nav-link {{ ($routeName == 'transfer-received.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Received Transfer</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
                @endif
                @if(!empty($aclList[18][1]) || !empty($aclList[18][2]))
                <li class="nav-item has-treeview {{ ($routeName == 'production.index' || $routeName == 'production.create') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Production
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[18][1]))
                        <li class="nav-item">
                            <a href="{{route("production.index")}}"
                               class="nav-link {{ ($routeName == 'production.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Production List</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[18][2]))
                        <li class="nav-item">
                            <a href="{{route("production.create")}}"
                               class="nav-link {{ ($routeName == 'production.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Production Create</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
                @endif
                @if(!empty($aclList[19][1]) || !empty($aclList[19][2]))
                <li class="nav-item has-treeview {{ ($routeName == 'brand.index' || $routeName == 'brand.create' || $routeName == 'brand.edit') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Brand
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[19][1]))
                        <li class="nav-item">
                            <a href="{{route("brand.index")}}"
                               class="nav-link {{ ($routeName == 'brand.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Brand List</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[19][2]))
                        <li class="nav-item">
                            <a href="{{route("brand.create")}}"
                               class="nav-link {{ ($routeName == 'brand.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Brand Create</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
@endif
                @if(!empty($aclList[20][1]) || !empty($aclList[20][2]))
                <li class="nav-item has-treeview {{ ($routeName == 'suppliers.index' || $routeName == 'suppliers.create' || $routeName == 'suppliers.edit') ? 'menu-open' : '' }}">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Supplier
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[20][1]))
                            <li class="nav-item">
                                <a href="{{route("suppliers.index")}}"
                                   class="nav-link {{ ($routeName == 'suppliers.index') ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Supplier List</p>
                                </a>
                            </li>
                        @endif
                            @if(!empty($aclList[20][2]))
                        <li class="nav-item">
                            <a href="{{route("suppliers.create")}}"
                               class="nav-link {{ ($routeName == 'suppliers.create') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Supplier Create</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
                @endif

                @if(!empty($aclList[25][1]) || !empty($aclList[26][1]) || !empty($aclList[27][1]) || !empty($aclList[28][1])
                || !empty($aclList[30][1]) || !empty($aclList[29][1]) || !empty($aclList[31][1]) || !empty($aclList[32][1]))

                    <li class="nav-item has-treeview {{ ($routeName == 'order-report.get' || $routeName == 'transfer-report.get'
                    || $routeName == 'receive-transfer-report.get' || $routeName == 'product-stock.get'
                    || $routeName == 'product-register-stock.get' || $routeName == 'product-adjustment.get'
                    || $routeName == 'low-quantity.get' || $routeName == 'production-report.get') ? 'menu-open' : '' }}">

                        <a href="#"
                           class="nav-link">
                            <i class="nav-icon fas fa-cog"></i>
                            <p>
                                Reports
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            @if(!empty($aclList[25][1]))
                                <li class="nav-item">
                                    <a href="{{route("order-report.get")}}"
                                       class="nav-link {{ ($routeName == 'order-report.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Order Report</p>
                                    </a>
                                </li>
                            @endif
                                @if(!empty($aclList[26][1]))
                                <li class="nav-item">
                                    <a href="{{route("low-quantity.get")}}"
                                       class="nav-link {{ ($routeName == 'low-quantity.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Quantity Report</p>
                                    </a>
                                </li>
                                @endif
                                @if(!empty($aclList[27][1]))
                                <li class="nav-item">
                                    <a href="{{route("production-report.get")}}"
                                       class="nav-link {{ ($routeName == 'production-report.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Production Report</p>
                                    </a>
                                </li>
                                @endif

                            @if(!empty($aclList[28][1]))
                                <li class="nav-item">
                                    <a href="{{route("transfer-report.get")}}"
                                       class="nav-link {{ ($routeName == 'transfer-report.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Transfer Report</p>
                                    </a>
                                </li>
                            @endif
                            @if(!empty($aclList[30][1]))
                                <li class="nav-item">
                                    <a href="{{route("receive-transfer-report.get")}}"
                                       class="nav-link {{ ($routeName == 'receive-transfer-report.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Transfer Receive Report</p>
                                    </a>
                                </li>
                            @endif

                            @if(!empty($aclList[29][1]))
                                <li class="nav-item">
                                    <a href="{{route("product-stock.get")}}"
                                       class="nav-link {{ ($routeName == 'product-stock.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Stock Report</p>
                                    </a>
                                </li>
                            @endif

                            @if(!empty($aclList[31][1]))
                                <li class="nav-item">
                                    <a href="{{route("product-register-stock.get")}}"
                                       class="nav-link {{ ($routeName == 'product-register-stock.get') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Stock Register Report</p>
                                    </a>
                                </li>
                            @endif
                            @if(!empty($aclList[32][1]))
                            <li class="nav-item">
                                <a href="{{route("product-adjustment.get")}}"
                                   class="nav-link {{ ($routeName == 'product-adjustment.get') ? 'active' : '' }}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Adjustment Report</p>
                                </a>
                            </li>
                        @endif

                        </ul>
                    </li>
                @endif

                @if(!empty($aclList[4][1]) || !empty($aclList[5][1]) || !empty($aclList[1][1]) || !empty($aclList[21][1])
                || !empty($aclList[22][1]) || !empty($aclList[23][3]) || !empty($aclList[24][1] ))
                <li class="nav-item has-treeview {{ ($routeName == 'activity.index' || $routeName == 'activity.create'
                || $routeName == 'activity.edit' || $routeName == 'module.index' || $routeName == 'module.create'
                || $routeName == 'module.edit' || $routeName == 'site.setting.edit' || $routeName == 'warehouse.index' || $routeName == 'warehouse.create'
                || $routeName == 'warehouse.edit' || $routeName == 'unit.index' || $routeName == 'unit.create'
                || $routeName == 'unit.edit' || $routeName == 'email-receiver.index') ? 'menu-open' : '' }}">
                    <a href="#"
                       class="nav-link">
                        <i class="nav-icon fas fa-cog"></i>
                        <p>
                            Setting
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        @if(!empty($aclList[24][1]))
                        <li class="nav-item">
                            <a href="{{route("email-receiver.index")}}"
                               class="nav-link {{ ($routeName == 'email-receiver.index') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Email Receiver</p>
                            </a>
                        </li>
                        @endif
                        @if(!empty($aclList[21][1]))
                        <li class="nav-item">
                            <a href="{{route("warehouse.index")}}"
                               class="nav-link {{ ($routeName == 'warehouse.index' || $routeName == 'warehouse.create'|| $routeName == 'warehouse.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Warehouse</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[22][1]))
                        <li class="nav-item">
                            <a href="{{route("unit.index")}}"
                               class="nav-link {{ ($routeName == 'unit.index' || $routeName == 'unit.create'|| $routeName == 'unit.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Unit</p>
                            </a>
                        </li>
                            @endif
                        @if(!empty($aclList[4][1]))
                        <li class="nav-item">
                            <a href="{{route("module.index")}}"
                               class="nav-link {{ ($routeName == 'module.index' || $routeName == 'module.create'|| $routeName == 'module.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Module Management</p>
                            </a>
                        </li>
                        @endif
                        @if(!empty($aclList[5][1]))
                        <li class="nav-item">
                            <a href="{{route("activity.index")}}"
                               class="nav-link {{ ($routeName == 'activity.index' || $routeName == 'activity.create'|| $routeName == 'activity.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Activity Management</p>
                            </a>
                        </li>
                        @endif
                            @if(!empty($aclList[23][3]))
                        <li class="nav-item">
                            <a href="{{route("site.setting.edit")}}"
                               class="nav-link {{ ($routeName == 'site.setting.edit') ? 'active' : '' }}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Site Setting</p>
                            </a>
                        </li>
                                @endif
                    </ul>
                </li>
                @endif
                <li class="nav-item">
                    <a href="{{route('admin.logout')}}" class="nav-link">
                        <i class="nav-icon fas fa-sign-out-alt"></i>
                        <p>
                            Logout
                        </p>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
