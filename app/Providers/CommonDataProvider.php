<?php

namespace App\Providers;

use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class CommonDataProvider extends ServiceProvider
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
        View::composer('*', function ($view) {
            $view->with('fieldTypeArr', [
                1 => 'text field',
                2 => 'email',
                3 => 'number',
                4 => 'textarea',
                5 => 'select',
                6 => 'radio',
                7 => 'checkbox',
                8 => 'file'
            ]);
        });
    }
}
