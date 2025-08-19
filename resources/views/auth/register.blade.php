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
            <img src="{{ asset('images/ebili-logo.png') }}" alt="Logo">
            <h5 class="mt-2 fw-bold">Register a new membership</h5>
        </div>

        @if(session('error'))
            <div class="alert alert-danger">{{ session('error') }}</div>
        @endif
        @if(session('status'))
            <div class="alert alert-danger">{{ session('status') }}</div>
        @endif
        @if ($errors->any())
            <div class="alert alert-danger">{{ $errors->first() }}</div>
        @endif

        <form action="{{ route('register') }}" method="POST">
            @csrf

            <div class="mb-3 position-relative">
                <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            </div>

            <div class="mb-3 position-relative">
                <input type="text" name="mobile_number" id="mobile_number" class="form-control"
                    placeholder="Mobile Number" required
                    maxlength="11" minlength="11" pattern="[0-9]{11}" inputmode="numeric"
                    oninput="validateMobile(this)">
                <small id="mobileError" class="text-danger d-none">Your 11-digits mobile number</small>
            </div>

            <div class="mb-3 position-relative">
                <input type="password" name="password" id="passwordInput" class="form-control" placeholder="Password" required>
                <span class="eye-icon" onclick="togglePassword('passwordInput', 'toggleIcon')">
                    <i id="toggleIcon" class="bi bi-eye-slash fs-5"></i>
                </span>
            </div>

            <div class="mb-3 position-relative">
                <input type="password" name="password_confirmation" id="confirmPasswordInput" class="form-control" placeholder="Confirm Password" required>
                <span class="eye-icon" onclick="togglePassword('confirmPasswordInput', 'toggleIconConfirm')">
                    <i id="toggleIconConfirm" class="bi bi-eye-slash fs-5"></i>
                </span>
            </div>

            <!-- Membership Payment Option -->
            <div class="mb-3">
                <label class="form-label">Membership Payment</label>
                <select name="payment_option" id="paymentOption" class="form-control" required>
                    <option value="">Select Payment Option</option>
                    <option value="pay_now">Pay Now</option>
                    <option value="pay_later">Pay Later</option>
                </select>
            </div>

            <!-- Payment Proof Section (Hidden by default) -->
            <div id="paymentProofSection" class="mb-3 d-none">
                <label class="form-label">Payment Proof</label>
                <select name="payment_method" id="paymentMethod" class="form-control mb-2">
                    <option value="ebili_qr">Scan QR to Pay</option>
                </select>

                <!-- QR Code Display -->
                <div id="qrCodeSection" class="mb-2 d-none">
                    <div class="text-center">
                        <img src="{{ asset('images/ebili-QR.png') }}" alt="E-Bili QR Code" class="img-fluid" style="max-width: 200px;">
                        <p class="mt-2">Scan this QR code to make payment</p>
                    </div>
                </div>

                <!-- Upload Payment Proof -->
                <div class="mb-2">
                    <label for="payment_proof" class="form-label">Upload Payment Proof</label>
                    <input type="file" name="payment_proof" id="payment_proof" class="form-control" accept="image/*">
                </div>
            </div>

            <button type="submit" class="btn btn-primary btn-md w-100">
                Register <i class="fa fa-user-plus ms-1"></i>
            </button>
        </form>

        <div class="small-links">
            <a href="{{ route('login') }}">I already have a membership</a>
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
        const nameInput = document.querySelector('input[name="name"]');
        if (nameInput) nameInput.focus();

        // Payment option change handler
        const paymentOption = document.getElementById('paymentOption');
        const paymentProofSection = document.getElementById('paymentProofSection');
        const paymentMethod = document.getElementById('paymentMethod');
        const qrCodeSection = document.getElementById('qrCodeSection');

        if (paymentOption) {
            paymentOption.addEventListener('change', function() {
                if (this.value === 'pay_now') {
                    paymentProofSection.classList.remove('d-none');
                    qrCodeSection.classList.remove('d-none');
                } else {
                    paymentProofSection.classList.add('d-none');
                    qrCodeSection.classList.add('d-none');
                }
            });
        }

        if (paymentMethod) {
            paymentMethod.addEventListener('change', function() {
                if (this.value === 'ebili_qr') {
                    qrCodeSection.classList.remove('d-none');
                } else {
                    qrCodeSection.classList.add('d-none');
                }
            });
        }
    });
</script>

@endsection
