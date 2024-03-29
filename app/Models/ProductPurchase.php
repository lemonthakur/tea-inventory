<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class ProductPurchase extends Model
{
    protected $table = 'product_purchases';

    public function product()
    {
    	return $this->belongsTo('App\Models\Product');
    }
    
}
