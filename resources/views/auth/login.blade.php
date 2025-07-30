@extends('layouts.guest')

@section('content')

<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap');

    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: 'Roboto', sans-serif;
        background-color: #f8f9fa;
        transition: background-color 0.3s ease;
    }

    body.dark-mode {
        background-color: #121212;
        color: #e0e0e0;
    }

    .login-page-wrapper {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }

    .login-card {
        background-color: #ffffff;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        padding: 30px;
        width: 100%;
        max-width: 400px;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    body.dark-mode .login-card {
        background-color: #1e1e1e;
        color: #e0e0e0;
        border-color: #333;
    }

    .login-logo {
        text-align: center;
        margin-bottom: 20px;
    }

    .login-logo img {
        width: 80px;
        height: auto;
    }

    .form-control {
        border-radius: 12px;
        padding-right: 2.5rem;
        font-size: 1rem;
    }

    .form-control:focus {
        box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
    }

    .eye-icon {
        position: absolute;
        top: 50%;
        right: 15px;
        transform: translateY(-50%);
        cursor: pointer;
        color: #6c757d;
        z-index: 10;
    }

  .btn-primary {
    background-color: #63189e !important;
    border-color: #63189e !important;
}
.btn-primary:hover {
    background-color: #531185 !important;
    border-color: #531185 !important;
}

    .small-links {
        font-size: 0.85rem;
        margin-top: 18px;
        text-align: center;
    }

    .small-links a {
        color: #7207a0;
        text-decoration: none;
        margin: 0 8px;
    }

    .small-links a:hover {
        text-decoration: underline;
    }
</style>

<div class="login-page-wrapper">
    <div class="login-card">
        <div class="login-logo">
            <img src="{{ asset('logo.png') }}" alt="Logo">
            <h5 class="mt-2 fw-bold">E-Bili Online</h5>
        </div>
        {{-- <p class="text-center mb-4">Welcome back! please enter your registered mobile number to proceed. <hr><center>Ang Bagong Bayanihan, Digital na.<hr></hr></p> --}}

        @if(session('error'))
            <div class="alert alert-danger">{{ session('error') }}</div>
        @endif
        @if(session('status'))
            <div class="alert alert-danger">{{ session('status') }}</div>
        @endif
        @if ($errors->any())
            <div class="alert alert-danger">{{ $errors->first() }}</div>
        @endif

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <div class="mb-3 position-relative">
                <input type="tel" name="mobile_number" id="mobile_number" class="form-control"
                    placeholder="Enter mobile number (e.g. 09171234567)"
                    maxlength="11" minlength="11" pattern="[0-9]{11}" inputmode="numeric" required
                    oninput="validateMobile(this)">
                <small id="mobileError" class="text-danger d-none">Your registered 11-digits mobile number</small>
            </div>

            <div class="mb-3 position-relative">
                <input type="password" class="form-control" id="passwordInput" name="password"
                    placeholder="Enter password" required>
                <span class="eye-icon" onclick="togglePassword('passwordInput', 'toggleIcon')">
                    <i id="toggleIcon" class="bi bi-eye-slash fs-5"></i>
                </span>
            </div>

            <button type="submit" class="btn btn-primary btn-md w-100">
                Login <i class="fa fa-sign-in ms-1"></i>
            </button>
            </form>

        <div class="small-links">
            <a href="{{ route('guest.register') }}">Create Account</a>
            <span>|</span>
            <a href="{{ route('password.request') }}">Forgot Password?</a>
        </div>
    </div>
</div>

    <hr>
<p class="small text-muted text-center mb-3">Shop to Save, Share to Earn! &copy; 2025</p>


<script>
    function validateMobile(input) {
        input.value = input.value.replace(/\D/g, '');
        const errorMsg = document.getElementById('mobileError');
        errorMsg.classList.toggle('d-none', input.value.length === 11);
    }

    document.addEventListener('DOMContentLoaded', function () {
        const mobileInput = document.getElementById('mobile_number');
        if (mobileInput) mobileInput.focus();
    });
</script>

<!-- Place this at the bottom before closing </body> -->
<script>
    let deferredPrompt = null;

    function showInstallToast() {
        const toast = document.getElementById('installToast');
        toast.style.display = 'block';
        new bootstrap.Toast(toast).show();
    }

    function hideInstallToast() {
        const toast = document.getElementById('installToast');
        toast.style.display = 'none';
    }

    window.addEventListener('beforeinstallprompt', (e) => {
        e.preventDefault();
        deferredPrompt = e;
        showInstallToast();
    });

    document.getElementById('installBtn').addEventListener('click', async () => {
        if (deferredPrompt) {
            deferredPrompt.prompt();
            const { outcome } = await deferredPrompt.userChoice;
            if (outcome === 'accepted') {
                console.log('User installed the app');
            }
            deferredPrompt = null;
            hideInstallToast();
        }
    });
</script>

@endsection
