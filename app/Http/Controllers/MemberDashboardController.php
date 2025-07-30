<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wallet;
use App\Models\RewardWinner;
use App\Models\Product;
use App\Models\Category;

class MemberDashboardController extends Controller


{  


  public function index()
{
    $user = auth()->user();
    $member = $user->member;

    if (!$member) {
        return redirect()->route('login')->with('error', 'Member not found.');
    }

    $wallet = $member->wallet;
    if (!$wallet) {
        $wallet = $member->wallet()->create([
            'balance' => 0,
            'wallet_id' => Wallet::generateWalletId(),
            'user_id' => $user->id,
            'member_id' => $member->id,
        ]);
    }

    $qualifiedToBorrow = $member->loan_eligible ?? now()->greaterThanOrEqualTo($user->created_at->addMonths(3));

    $latestWin = RewardWinner::with('program')
        ->where('member_id', $member->id)
        ->where('status', 'unclaimed')
        ->where('seen', false)
        ->latest('drawn_at')
        ->first();

    if ($latestWin) {
        $latestWin->update(['seen' => true]);
    }

    // 🛍️ Load 8 random featured products with thumbnails
    $products = Product::whereNotNull('thumbnail')->inRandomOrder()->take(8)->get();
    
    // Load categories with images for display
    $categories = Category::all();

    return view('dashboard.member', [
        'wallet' => $wallet,
        'qualifiedToBorrow' => $qualifiedToBorrow,
        'latestWin' => $latestWin,
        'products' => $products,
        'categories' => $categories,
    ]);
}


}
