<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class Transfer extends Model
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
    
    public function fromWarehouse()
    {
    	return $this->belongsTo('App\Models\Warehouse', 'from_warehouse_id');
    }

    public function toWarehouse()
    {
    	return $this->belongsTo('App\Models\Warehouse', 'to_warehouse_id');
    }

    public function user()
    {
    	return $this->belongsTo('App\Models\User', 'user_id');
    }
}
