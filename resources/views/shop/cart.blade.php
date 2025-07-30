@extends('adminlte::page')
@section('title', 'Your Cart')

@section('content')
<div class="container-fluid px-2">
    <h5 class="mb-3"><i class="bi bi-cart me-1"></i> Your Shopping Cart</h5>

    @if(count($cart) > 0)
        <div class="table-responsive">
            <table class="table table-bordered table-hover rounded shadow-sm align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Product</th>
                        <th class="text-center">Qty</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    @php
                        $total = 0;
                        $totalCashback = 0;
                    @endphp
                    @foreach($cart as $id => $item)
                        @php
                            $subtotal = $item['price'] * $item['quantity'];
                            $total += $subtotal;
                            $totalCashback += ($item['cashback'] ?? 0) * $item['quantity'];
                        @endphp
                        <tr>
                            <td>
                                @if(!empty($item['thumbnail']))
                                    <img src="{{ asset('storage/' . $item['thumbnail']) }}"
                                         alt="{{ $item['name'] }}"
                                         style="width: 40px; height: 40px; object-fit: cover; border-radius: 6px;"
                                         class="me-2">
                                @endif
                                <strong>{{ $item['name'] }}</strong><br>
                                <small class="text-muted">Cashback: ₱{{ number_format($item['cashback'] ?? 0, 2) }}</small>
                            </td>
                            <td class="text-center">
                                <form action="{{ route('shop.cart.update', $id) }}" method="POST" class="d-inline-flex gap-1">
                                    @csrf
                                    @method('PATCH')
                                    <button name="action" value="decrease" class="btn btn-sm btn-light">−</button>
                                    <span class="px-2">{{ $item['quantity'] }}</span>
                                    <button name="action" value="increase" class="btn btn-sm btn-light">＋</button>
                                </form>
                            </td>
                            <td>₱{{ number_format($item['price'], 2) }}</td>
                            <td>₱{{ number_format($subtotal, 2) }}</td>
                            <td>
                                <form action="{{ route('shop.cart.remove', $id) }}" method="POST">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger rounded-circle">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <div class="text-end fw-bold mt-3">
            Total: ₱{{ number_format($total, 2) }}<br>
            Cashback: ₱{{ number_format($totalCashback, 2) }}<br>
            Wallet: <span class="text-success">₱{{ number_format(auth()->user()->member->wallet_balance ?? 0, 2) }}</span>
        </div>

        <div class="mt-4 d-flex justify-content-between">
            <a href="{{ route('shop.index') }}" class="btn btn-secondary rounded-pill">
                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
            </a>
   <a href="{{ route('shop.checkout.page') }}" class="btn btn-primary rounded-pill">
    🧾 Proceed to Checkout
</a>
        </div>

        <!-- Modal Summary -->
        <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <div class="modal-content rounded-4">
                    <div class="modal-header">
                        <h5 class="modal-title">🧾 Order Summary</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        @foreach($cart as $item)
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <strong>{{ $item['name'] }}</strong>
                                    <br><small>{{ $item['quantity'] }} × ₱{{ number_format($item['price'], 2) }}</small>
                                </div>
                                <span>₱{{ number_format($item['price'] * $item['quantity'], 2) }}</span>
                            </div>
                        @endforeach
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total</span>
                            <span>₱{{ number_format($total, 2) }}</span>
                        </div>
                        <div class="d-flex justify-content-between text-muted">
                            <span>Cashback</span>
                            <span>₱{{ number_format($totalCashback, 2) }}</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Wallet Balance</span>
                            <span class="text-success">₱{{ number_format(auth()->user()->member->wallet_balance ?? 0, 2) }}</span>
                        </div>
                    </div>
                    <div class="modal-footer">
    <form action="{{ route('shop.checkout') }}" method="POST" enctype="multipart/form-data" class="w-100">
        @csrf

        <div class="mb-3">
            <label for="payment_method" class="form-label">Payment Method</label>
            <select class="form-select" name="payment_method" id="payment_method" required>
                <option value="Wallet">Wallet</option>
                <option value="GCash">GCash</option>
                <option value="Bank">Bank Transfer</option>
                <option value="COD">Cash on Delivery</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="reference_image" class="form-label">Payment Proof (Optional)</label>
            <input type="file" name="reference_image" class="form-control">
        </div>

        <div class="mb-3">
            <label for="delivery_type" class="form-label">Delivery Type</label>
            <select name="delivery_type" class="form-select" required>
                <option value="delivery">Delivery</option>
                <option value="pickup">Pickup</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="delivery_address" class="form-label">Delivery Address</label>
            <textarea name="delivery_address" class="form-control" rows="2" required>{{ auth()->user()->member->address ?? '' }}</textarea>
        </div>

        <div class="mb-3">
            <label for="contact_number" class="form-label">Contact Number</label>
            <input type="text" name="contact_number" class="form-control" value="{{ auth()->user()->member->mobile ?? '' }}" required>
        </div>

        <button type="submit" class="btn btn-success w-100 rounded-pill">✅ Confirm and Pay</button>
    </form>
</div>

                </div>
            </div>
        </div>

    @else
        <div class="alert alert-info rounded-3">
            Your cart is empty.
        </div>
    @endif
</div>
@endsection
@include('partials.mobile-footer')


@push('js')
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const paymentMethod = document.getElementById('payment_method');
        const proofGroup = document.querySelector('input[name="reference_image"]').closest('.mb-3');

        function toggleProof() {
            const value = paymentMethod.value;
            if (value === 'Wallet' || value === 'COD') {
                proofGroup.style.display = 'none';
            } else {
                proofGroup.style.display = 'block';
            }
        }

        paymentMethod.addEventListener('change', toggleProof);
        toggleProof(); // run on page load
    });
</script>
@endpush
