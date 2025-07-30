<?php

namespace App\Http\Controllers\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function showLoginForm()
    {
        return view('auth.login');
    }
public function login(Request $request)
{
    $credentials = $request->validate([
        'mobile_number' => 'required',
        'password' => 'required',
    ]);

    if (Auth::attempt([
        'mobile_number' => $credentials['mobile_number'],
        'password' => $credentials['password']
    ])) {
        $request->session()->regenerate();

        $user = Auth::user();

        // ✅ Check if status is pending
        if ($user->status === 'Pending') {
            Auth::logout(); // log out immediately
            return back()->with('error', 'Your registration is still pending approval by the admin.');
        }

        // ✅ Redirect based on role
        switch ($user->role) {
            case 'Admin':
                return redirect()->route('admin.dashboard');
            case 'Staff':
                return redirect()->route('staff.dashboard');
            case 'Member':
                return redirect()->route('member.dashboard');
            default:
                Auth::logout();
                return back()->with('error', 'Unauthorized access.');
        }
    }

    return back()->with('error', 'Invalid mobile number or password.');
}

public function logout(Request $request)
{
    Auth::logout();

    $request->session()->invalidate();
    $request->session()->regenerateToken();

    return redirect('/'); // or route('login') if preferred
}


}
