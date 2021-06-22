<?php

namespace App\Console\Commands;

use App\Models\MailReceiver;
use App\Models\Product_Warehouse;
use App\Models\SiteSetting;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class SendEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'send-email:cron';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send email with low warning of stock';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $siteSetting = SiteSetting::select('alert_quantity')->find(1);
        $data = [];
        if($siteSetting) {
            $products = Product_Warehouse::with(['product:id,name,code,unit_id', 'product.unit:id,name', 'warehouse:id,name'])
                ->orderBy('warehouse_id')
                ->where('qty', '<=', $siteSetting->alert_quantity)
                ->get();
            if ($products) {
                $receivers = MailReceiver::with((['user:id,email']))->orderBy('id', 'desc')->get();
                if (!empty($receivers)) {
                    $emails = [];
                    foreach ($receivers as $receiver) {
                        array_push($emails, $receiver->user->email);
                    }

                    Mail::to($emails)->send(new \App\Mail\ReceiverMail($products));
                }
            }
        }
    }
}
