<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class ProductionEmployee extends Model
{
    public static function boot()
    {
        parent::boot();
        static::creating(function($post)
        {
            $post->created_by = Auth::id();
            $post->updated_by = Auth::id();
        });

        static::updating(function($post)
        {
            $post->updated_by = Auth::id();
        });
    }
}
