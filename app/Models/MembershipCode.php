<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class MembershipCode extends Model
{
    protected $fillable = ['code', 'used', 'used_by', 'used_at', 'reserved', 'reserved_by'];

    protected $casts = [
        'used' => 'boolean',
        'reserved' => 'boolean'
    ];

    public static function generateCode()
    {
        do {
            $code = strtoupper(Str::random(8));
        } while (self::where('code', $code)->exists());

        return self::create(['code' => $code]);
    }

    public function markAsUsed($userId)
    {
        $this->update([
            'used' => true,
            'used_by' => $userId,
            'used_at' => now(),
            'reserved' => false,
            'reserved_by' => null
        ]);
    }

    public function markAsReserved($requestId)
    {
        $this->update([
            'reserved' => true,
            'reserved_by' => $requestId
        ]);
    }

    public function releaseReservation()
    {
        $this->update([
            'reserved' => false,
            'reserved_by' => null
        ]);
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'used_by');
    }

    public function reservation()
    {
        return $this->belongsTo(MembershipCodeRequest::class, 'reserved_by');
    }

    public function scopeAvailable($query)
    {
        return $query->where(function($q) {
            $q->where('used', false)->orWhereNull('used');
        })->where('reserved', false);
    }
}
