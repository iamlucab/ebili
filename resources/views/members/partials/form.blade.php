{{-- E-Bili Theme Styling --}}
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="{{ asset('css/ebili-theme.css') }}">

<div class="row g-3">
    {{-- Personal Information Section --}}
    <div class="col-12">
        <h5 class="section-title text-start" style="font-size: 1.1rem;">
            <i class="bi bi-person me-2"></i> Personal Information
        </h5>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-person me-1"></i> First Name <span class="text-danger">*</span>
        </label>
        <input type="text" name="first_name" class="form-control"
               value="{{ old('first_name', $member->first_name ?? '') }}" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-person me-1"></i> Middle Name
        </label>
        <input type="text" name="middle_name" class="form-control"
               value="{{ old('middle_name', $member->middle_name ?? '') }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-person me-1"></i> Last Name <span class="text-danger">*</span>
        </label>
        <input type="text" name="last_name" class="form-control"
               value="{{ old('last_name', $member->last_name ?? '') }}" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-cake me-1"></i> Birthday <span class="text-danger">*</span>
        </label>
        <input type="date" name="birthday" class="form-control"
               value="{{ old('birthday', $member->birthday ?? '') }}" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-phone me-1"></i> Mobile Number <span class="text-danger">*</span>
        </label>
        <input type="text" name="mobile_number" class="form-control"
               value="{{ old('mobile_number', $member->mobile_number ?? '') }}" required>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-envelope me-1"></i> Email
        </label>
        <input type="email" name="email" class="form-control"
               value="{{ old('email', $member->user->email ?? '') }}">
        <small class="text-muted">
            <i class="bi bi-info-circle me-1"></i> Optional - for login and notifications
        </small>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-briefcase me-1"></i> Occupation
        </label>
        <input type="text" name="occupation" class="form-control"
               value="{{ old('occupation', $member->occupation ?? '') }}">
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-geo-alt me-1"></i> Address
        </label>
        <input type="text" name="address" class="form-control"
               value="{{ old('address', $member->address ?? '') }}">
    </div>

    {{-- System Information Section --}}
    <div class="col-12 mt-4">
        <h5 class="section-title text-start" style="font-size: 1.1rem;">
            <i class="bi bi-gear-fill me-2"></i> System Information
        </h5>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-person-tag me-1"></i> Role <span class="text-danger">*</span>
        </label>
        <select name="role" class="form-control" required>
            <option value="Admin" {{ old('role', $member->role ?? '') == 'Admin' ? 'selected' : '' }}>Admin</option>
            <option value="Staff" {{ old('role', $member->role ?? '') == 'Staff' ? 'selected' : '' }}>Staff</option>
            <option value="Member" {{ old('role', $member->role ?? '') == 'Member' ? 'selected' : '' }}>Member</option>
        </select>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-handshake me-1"></i> Sponsor
        </label>
        <select name="sponsor_id" class="form-control" id="sponsorSelect">
            <option value="">-- Select Sponsor --</option>
            @foreach ($sponsors->where('status', 'Approved') as $sponsor)
                <option value="{{ $sponsor->id }}"
                        {{ old('sponsor_id', $member->sponsor_id ?? '') == $sponsor->id ? 'selected' : '' }}>
                    {{ $sponsor->first_name }} {{ $sponsor->last_name }}
                </option>
            @endforeach
        </select>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-check-circle me-1"></i> Status <span class="text-danger">*</span>
        </label>
        <select name="status" class="form-control" id="statusSelect">
            <option value="Pending" {{ old('status', $member->status ?? '') == 'Pending' ? 'selected' : '' }}>Pending</option>
            <option value="Approved" {{ old('status', $member->status ?? '') == 'Approved' ? 'selected' : '' }}>Approved</option>
        </select>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-qr-code me-1"></i> Membership Code <span class="text-danger">*</span>
        </label>
        <select name="membership_code" class="form-control" required>
            <option value="">-- Select Membership Code --</option>
            @php
                $unusedCodes = \App\Models\MembershipCode::where('used', false)->get();
                $currentCode = isset($member) && $member->membershipCode ? $member->membershipCode : null;
            @endphp

            {{-- Show current code if editing --}}
            @if ($currentCode)
                <option value="{{ $currentCode->code }}" selected>
                    {{ $currentCode->code }} (Current)
                </option>
            @endif

            {{-- Show unused codes --}}
            @foreach ($unusedCodes as $code)
                @if (!$currentCode || $code->code !== $currentCode->code)
                    <option value="{{ $code->code }}">{{ $code->code }}</option>
                @endif
            @endforeach
        </select>
        <small class="text-muted">
            <i class="bi bi-info-circle me-1"></i> Only unused codes are shown
        </small>
    </div>

    {{-- Payment Information Section --}}
    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-credit-card me-1"></i> Payment Status
        </label>
        <select name="payment_status" class="form-control">
            <option value="Pending" {{ old('payment_status', $member->payment_status ?? '') == 'Pending' ? 'selected' : '' }}>Pending</option>
            <option value="Approved" {{ old('payment_status', $member->payment_status ?? '') == 'Approved' ? 'selected' : '' }}>Approved</option>
            <option value="Rejected" {{ old('payment_status', $member->payment_status ?? '') == 'Rejected' ? 'selected' : '' }}>Rejected</option>
        </select>
    </div>

    @if (isset($member) && $member->payment_proof)
        <div class="col-md-4">
            <label class="form-label">
                <i class="bi bi-image me-1"></i> Payment Proof
            </label>
            <div class="mt-2">
                <button type="button" class="btn btn-warning" onclick="showPaymentProof({{ $member->id }})">
                    <i class="bi bi-eye me-1"></i> View Proof
                </button>
            </div>
        </div>
    @endif

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-key me-1"></i> Reset Password (Optional)
        </label>
        <input type="password" name="new_password" class="form-control" placeholder="Leave blank to keep current password">
        <small class="text-muted">
            <i class="bi bi-info-circle me-1"></i> Enter new password to reset, or leave blank to keep current
        </small>
    </div>

    {{-- Additional Settings Section --}}
    <div class="col-12 mt-4">
        <h5 class="section-title text-start" style="font-size: 1.1rem;">
            <i class="bi bi-sliders me-2"></i> Additional Settings
        </h5>
    </div>

    <div class="col-md-4">
        <div class="card p-3">
            <div class="form-check">
                <input type="checkbox" name="loan_eligible" value="1" class="form-check-input" id="loanEligibleCheckbox"
                       {{ old('loan_eligible', $member->loan_eligible ?? false) ? 'checked' : '' }}>
                <label class="form-check-label fw-bold" for="loanEligibleCheckbox">
                    <i class="bi bi-cash-coin me-1" style="color: var(--primary-purple);"></i>
                    Eligible for Loan
                </label>
                <small class="text-muted d-block mt-1">
                    Allow this member to request loans
                </small>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <label class="form-label">
            <i class="bi bi-camera me-1"></i> Photo
        </label>
        <input type="file" name="photo" class="form-control" accept="image/*">
        @if (isset($member) && $member->photo)
            <div class="mt-3">
                <img src="{{ $member->photo_url }}"
                     width="80" height="80"
                     alt="Member Photo"
                     class="rounded-circle border border-3"
                     style="border-color: var(--primary-purple) !important; object-fit: cover;">
                <small class="text-muted d-block mt-1">Current photo</small>
            </div>
        @else
            <small class="text-muted d-block mt-1">
                <i class="bi bi-info-circle me-1"></i> No photo uploaded
            </small>
        @endif
    </div>
</div>

{{-- Payment Proof Modal --}}
@if (isset($member) && $member->payment_proof)
<div class="modal fade" id="paymentProofModal{{ $member->id }}" tabindex="-1" aria-labelledby="paymentProofModalLabel{{ $member->id }}" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="paymentProofModalLabel{{ $member->id }}">Payment Proof</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img src="{{ asset('storage/' . $member->payment_proof) }}"
                     class="img-fluid payment-proof-image"
                     alt="Payment Proof"
                     style="max-height: 80vh; cursor: zoom-in;"
                     onerror="this.src='{{ asset('images/default-proof.png') }}'; this.alt='Image not found';">
                <div class="mt-2">
                    <a href="{{ asset('storage/' . $member->payment_proof) }}"
                       download
                       class="btn btn-sm btn-outline-primary">
                        <i class="bi bi-download me-1"></i> Download Proof
                    </a>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
@endif

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const paymentProofImage = document.querySelector('.payment-proof-image');
        if (paymentProofImage) {
            let isZoomed = false;
            paymentProofImage.style.cursor = 'zoom-in';

            paymentProofImage.addEventListener('click', function() {
                if (isZoomed) {
                    this.style.transform = 'scale(1)';
                    this.style.cursor = 'zoom-in';
                    isZoomed = false;
                } else {
                    this.style.transform = 'scale(1.5)';
                    this.style.cursor = 'zoom-out';
                    this.style.transition = 'transform 0.3s ease';
                    isZoomed = true;
                }
            });

            const modal = document.getElementById('paymentProofModal{{ $member->id ?? '' }}');
            if (modal) {
                modal.addEventListener('hidden.bs.modal', function() {
                    paymentProofImage.style.transform = 'scale(1)';
                    paymentProofImage.style.cursor = 'zoom-in';
                    isZoomed = false;
                });
            }
        }
    });

    // Custom function to show payment proof
    function showPaymentProof(memberId) {
        // Create modal HTML
        const modalHtml = `
            <div id="customPaymentProofModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 10000; display: flex; justify-content: center; align-items: center;">
                <div style="background: white; border-radius: 8px; max-width: 90%; max-height: 90%; overflow: auto;">
                    <div style="padding: 15px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
                        <h5 style="margin: 0;">Payment Proof</h5>
                        <button onclick="closePaymentProofModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer;">&times;</button>
                    </div>
                    <div style="padding: 15px; text-align: center;">
                        <img src="{{ asset('storage/' . $member->payment_proof) }}"
                             alt="Payment Proof"
                             style="max-width: 100%; max-height: 70vh; cursor: zoom-in;"
                             onclick="toggleImageZoom(this)"
                             id="paymentProofImage">
                        <div style="margin-top: 15px;">
                            <a href="{{ asset('storage/' . $member->payment_proof) }}"
                               download
                               class="btn btn-sm btn-outline-primary"
                               style="text-decoration: none; padding: 5px 10px; border: 1px solid #0d6efd; color: #0d6efd; border-radius: 4px;">
                                <i class="bi bi-download me-1"></i> Download Proof
                            </a>
                        </div>
                    </div>
                    <div style="padding: 15px; border-top: 1px solid #eee; text-align: right;">
                        <button onclick="closePaymentProofModal()"
                                style="background: #6c757d; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">
                            Close
                        </button>
                    </div>
                </div>
            </div>
        `;

        // Add modal to body
        const modalElement = document.createElement('div');
        modalElement.innerHTML = modalHtml;
        document.body.appendChild(modalElement);

        // Prevent body scrolling
        document.body.style.overflow = 'hidden';
    }

    // Function to close the modal
    function closePaymentProofModal() {
        const modal = document.getElementById('customPaymentProofModal');
        if (modal) {
            modal.remove();
        }
        // Restore body scrolling
        document.body.style.overflow = '';
    }

    // Function to toggle image zoom
    function toggleImageZoom(img) {
        if (img.style.transform === 'scale(1.5)') {
            img.style.transform = 'scale(1)';
            img.style.cursor = 'zoom-in';
        } else {
            img.style.transform = 'scale(1.5)';
            img.style.cursor = 'zoom-out';
        }
    }

    // Close modal when clicking outside
    document.addEventListener('click', function(event) {
        const modal = document.getElementById('customPaymentProofModal');
        if (modal && event.target === modal) {
            closePaymentProofModal();
        }
    });

    // Close modal with Escape key
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closePaymentProofModal();
        }
    });
</script>

<style>
    .form-label {
        font-weight: 600;
        color: var(--primary-purple);
        margin-bottom: 0.5rem;
    }
    .form-control:focus {
        border-color: var(--primary-purple);
        box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
    }
    .form-check-input:checked {
        background-color: var(--primary-purple);
        border-color: var(--primary-purple);
    }
    .form-check-input:focus {
        box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
    }
    .text-danger {
        color: #dc3545 !important;
    }
    .section-title::after {
        width: 30px;
        left: 0;
        transform: none;
    }
</style>
