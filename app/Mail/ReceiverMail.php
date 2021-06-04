<?php

namespace App\Mail;

use App\Models\FormSubmit;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ReceiverMail extends Mailable
{
    use Queueable, SerializesModels;

    public $formSubmit;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(FormSubmit $formSubmit)
    {
        $this->formSubmit = $formSubmit;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('info@duckbd.com')
            ->subject('Form Submit Value')->view('emails.receiver-email')
            ->with('formSubmit', $this->formSubmit);
    }
}
