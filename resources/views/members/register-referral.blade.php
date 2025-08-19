@extends('adminlte::page')

@section('title', 'Join Through Referral')

@section('content_header')
    <h1>Join E-Bili Through Referral</h1>
@stop

@section('content')
    @if (session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Registration Form</h3>
        </div>
        <div class="card-body">
            <div class="alert alert-info">
                <h5>Referred by: {{ $sponsor->first_name }} {{ $sponsor->last_name }}</h5>
                <p>You were referred by <strong>{{ $sponsor->first_name }} {{ $sponsor->last_name }}</strong>.
                By registering through this link, both you and your sponsor will receive referral bonuses!</p>
            </div>

            <form action="{{ route('member.store') }}" method="POST" enctype="multipart/form-data" id="registerForm">
                @csrf
                <input type="hidden" name="sponsor_id" value="{{ $sponsor->id }}">

                <div class="row">
                    {{-- First Name --}}
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="first_name">First Name</label>
                            <input type="text" name="first_name" class="form-control" required>
                            @error('first_name') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Middle Name --}}
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="middle_name">Middle Name</label>
                            <input type="text" name="middle_name" class="form-control">
                            @error('middle_name') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Last Name --}}
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="last_name">Last Name</label>
                            <input type="text" name="last_name" class="form-control" required>
                            @error('last_name') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Birthday --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="birthday">Birthday</label>
                            <input type="date" name="birthday" class="form-control" required>
                            @error('birthday') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Mobile Number --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="mobile_number">Mobile Number <small class="text-muted">This mobile number is also his/her username. and the default password: is <code>secret123</code>.</small></label>
                            <input type="text" name="mobile_number" id="mobile_number" class="form-control"
                                   maxlength="11" pattern="\d{11}" title="Must be exactly 11 digits"
                                   oninput="this.value=this.value.replace(/[^0-9]/g,'')" required>
                            <small id="mobileFeedback" class="text-danger"></small>
                            @error('mobile_number') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Occupation --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="occupation">Occupation</label>
                            <input type="text" name="occupation" class="form-control">
                            @error('occupation') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Membership Code --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="membership_code">Membership Code</label>&nbsp;<small class="text-muted">(Pay and get it from the Admin.)</small>
                            <input type="text" name="membership_code" class="form-control" required>
                            @error('membership_code') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Payment Options --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Membership Payment</label>
                            <select name="payment_option" id="paymentOption" class="form-control" required>
                                <option value="">Select Payment Option</option>
                                <option value="pay_now">Pay Now (GCash)</option>
                                <option value="pay_later">Pay Later</option>
                            </select>
                            @error('payment_option') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    <!-- Payment Proof Section (Hidden by default) -->
                    <div id="paymentProofSection" class="col-md-6 d-none">
                        <div class="form-group">
                            <label class="form-label">Payment Method</label>
                            <select name="payment_method" id="paymentMethod" class="form-control mb-2">
                                <option value="gcash_qr">Scan QR to Pay</option>
                            </select>

                            <div id="qrCodeSection" class="mb-3 d-none">
                                <label class="form-label">GCash QR Code</label>
                                <div class="text-center">
                                    <img src="{{ asset('images/gcashQR.jpeg') }}" alt="GCash QR Code" class="img-fluid" style="max-width: 200px;">
                                    <p class="mt-2">Scan this QR code to make payment</p>
                                </div>
                            </div>

                            <div class="mb-2">
                                <label for="payment_proof" class="form-label">Upload Payment Proof</label>
                                <input type="file" name="payment_proof" id="payment_proof" class="form-control" accept="image/*">
                            </div>
                        </div>
                    </div>

                    {{-- Role --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="role">Select Role</label>
                            <input type="text" class="form-control" value="Member" readonly>
                            <input type="hidden" name="role" value="Member">
                            @error('role') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Photo Upload --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="photo">Upload Photo</label>
                            <input type="file" name="photo" class="form-control">
                            @error('photo') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>
                    </div>

                    {{-- Payment Status --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="payment_status">Payment Status</label>
                            <select name="payment_status" class="form-control">
                                <option value="Pending" selected>Pending</option>
                                <option value="Approved">Approved</option>
                                <option value="Rejected">Rejected</option>
                            </select>
                        </div>
                    </div>

                    {{-- Payment Proof Upload --}}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="payment_proof">Payment Proof</label>
                            <input type="file" name="payment_proof" class="form-control" accept="image/*">
                        </div>
                    </div>

                    {{-- Submit --}}
                    <div class="col-md-12 mt-3">
                        <button class="btn btn-primary" id="submitBtn">Register</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
@stop

@include('partials.mobile-footer')

@section('js')
<script>
    document.getElementById('mobile_number').addEventListener('blur', function() {
        const mobile = this.value;
        const feedback = document.getElementById('mobileFeedback');

        if (mobile.length === 11) {
            fetch(`/check-mobile?mobile_number=${mobile}`)
                .then(response => response.json())
                .then(data => {
                    if (data.exists) {
                        feedback.textContent = 'Mobile number already registered and approved.';
                        document.getElementById('submitBtn').disabled = true;
                    } else {
                        feedback.textContent = '';
                        document.getElementById('submitBtn').disabled = false;
                    }
                });
        } else {
            feedback.textContent = '';
        }
    });

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
            if (this.value === 'gcash_qr') {
                qrCodeSection.classList.remove('d-none');
            } else {
                qrCodeSection.classList.add('d-none');
            }
        });
    }
</script>
@endsection
