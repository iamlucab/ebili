<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MembershipCodeRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'member_id',
        'quantity',
        'amount_per_code',
        'total_amount',
        'payment_method',
        'proof_path',
        'note',
        'status'
    ];

    public function member()
    {
        return $this->belongsTo(Member::class);
    }

    public function reservedCodes()
    {
        return $this->belongsToMany(MembershipCode::class, 'membership_code_request_codes')
                    ->withPivot('reserved_at');
    }
}
