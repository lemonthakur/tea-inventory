<?php

namespace App\Http\Controllers;

use App\Models\Form;
use App\Models\FormSubmit;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(){
        return view("backend.dashboard.index");
    }
}
