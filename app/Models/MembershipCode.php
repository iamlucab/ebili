<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class MembershipCode extends Model
{
    protected $fillable = ['code', 'used', 'used_by', 'used_at'];

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
            'used_at' => now()
        ]);
    }

    public function user()
{
    return $this->belongsTo(User::class, 'used_by');
}


}
