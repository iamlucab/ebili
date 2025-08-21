<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Session\TokenMismatchException;

class LoginController extends Controller
{
    public function showLoginForm()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'login' => 'required|string',
            'password' => 'required',
        ]);

        // Determine if login is email or mobile number
        $loginField = filter_var($credentials['login'], FILTER_VALIDATE_EMAIL) ? 'email' : 'mobile_number';

        // Attempt authentication
        if (Auth::attempt([
            $loginField => $credentials['login'],
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

        return back()->with('error', 'Invalid credentials. Please check your email/mobile number and password.');
    }

    public function logout(Request $request)
    {
        try {
            Auth::logout();

            $request->session()->invalidate();
            $request->session()->regenerateToken();

            return redirect('/')->with('success', 'You have been successfully logged out.');
        } catch (TokenMismatchException $e) {
            // Handle token mismatch by redirecting to welcome page
            return redirect('/')->with('error', 'Your session has expired.');
        } catch (\Exception $e) {
            // Handle any other exceptions
            return redirect('/')->with('error', 'An error occurred during logout.');
        }
    }
}
