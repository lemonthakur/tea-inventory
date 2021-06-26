<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class Production extends Model
{
    use SoftDeletes;
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

    public function product()
    {
        return $this->belongsTo(Product::class,'product_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class,'warehouse_id');
    }

    public function employee()
    {
        return $this->belongsTo(User::class,'employee_id');
    }

    public function productionUse()
    {
        return $this->hasMany(ProductionUseProduct::class,'production_id');
    }

    public function employees()
    {
        return $this->hasMany(ProductionEmployee::class,'production_id');
    }

}
