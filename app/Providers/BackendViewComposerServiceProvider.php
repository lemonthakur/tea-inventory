<?php

namespace App\Providers;

use App\Models\SiteSetting;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class BackendViewComposerServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        View::composer('backend.*', function ($view) {
            $view->with('siteSetting',SiteSetting::find(1));
        });

//        View::composer('backend.*', function ($view) {
//            $view->with('routeName',\Illuminate\Support\Facades\Route::currentRouteName());
//        });
    }
}
