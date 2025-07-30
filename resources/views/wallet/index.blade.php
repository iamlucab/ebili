@extends('adminlte::page')

@section('title', 'My Wallet')

@section('css')
<link href="https://fonts.googleapis.com/css2?family=Roboto+Rounded&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Roboto Rounded', sans-serif;
    }

    .wallet-balance {
        font-size: 2rem;
        font-weight: bold;
        color: #198754;
    }

    .action-card {
        transition: transform 0.2s ease;
        border-radius: 1rem;
    }

    .action-card:hover {
        transform: scale(1.05);
    }

    .transaction-table td,
    .transaction-table th {
        font-size: 0.875rem;
    }

    input.is-invalid {
        border-color: #dc3545 !important;
    }
</style>
@endsection

@section('content_header')
<h1 class="fw-bold">Wallet</h1>
@stop

@section('content')
@php
    $cashback = auth()->user()->member->cashbackWallet;
    $cashbackBalance = $cashback?->balance ?? 0;
@endphp

<div class="container-fluid">
    {{-- Wallet Cards --}}
    <div class="card rounded-4 shadow-sm mb-4">
        <div class="card-body">
            <div class="row gx-3 gy-3">
             {{-- Main Wallet --}}
    <div class="col-6">
        <a href="{{ route('wallet.history', ['type' => 'main']) }}" class="text-decoration-none">
            <div class="wallet-card p-3 text-center h-100" style="color: white !important;">
                <small class="text-uppercase d-block" style="font-size: 75%; opacity: 0.9; color: white !important;">Available Balance</small>
                @isset($wallet)
                    <h3 class="fw-bold mt-2 mb-2" style="color: white !important;">₱{{ number_format($wallet->balance, 2) }}</h3>
                @endisset
                <div class="mt-1 small" style="color: white !important;"><i class="bi bi-clock-history me-1"></i> View History</div>
            </div>
        </a>
    </div>

                {{-- Cashback Wallet --}}
                <div class="col-6">
                    <div class="bg-warning text-dark rounded-lg p-3 shadow-sm text-center h-100">
                        <small class="text-uppercase" style="font-size: 75%;">Cashback Wallet</small>
                        <h4 class="fw-bold mt-1">₱{{ number_format($cashbackBalance, 2) }}</h4>
                        <div class="mt-1 small">
                            <a href="{{ route('wallet.history', ['type' => 'cashback']) }}" class="text-dark">
                                <i class="bi bi-clock-history"></i> View Cashback
                            </a>
                            @if($cashbackBalance > 0)
                            <br>
                            <button type="button" class="btn btn-sm btn-dark mt-2" data-bs-toggle="modal" data-bs-target="#cashbackTransferModal">
                                <i class="bi bi-shuffle"></i> Transfer to Main
                            </button>
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- Transactions --}}
    <div class="card rounded-4 shadow-sm">
        <div class="card-body">
            <h5 class="fw-bold mb-3">Top 10 Transactions</h5>
            <div class="table-responsive">
                <table class="table table-sm table-striped table-bordered transaction-table">
                    <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Type</th>
                            <th class="text-end">Amount</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($transactions as $txn)
                            <tr>
                                <td>{{ $txn->created_at->format('Y-m-d H:i') }}</td>
                                <td>{{ ucfirst($txn->type) }}</td>
                                <td class="text-end">₱{{ number_format($txn->amount, 2) }}</td>
                                <td>{{ $txn->description }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center text-muted">No transactions found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
{{-- Modal: Transfer Cashback (Always Rendered) --}}
<div class="modal fade" id="cashbackTransferModal" tabindex="-1" aria-labelledby="cashbackTransferModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="POST" action="{{ route('wallet.transfer.cashback') }}">
            @csrf
            <input type="hidden" name="_modal" value="cashback-transfer">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title text-white" id="cashbackTransferModalLabel">Transfer Cashback to Main Wallet</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">x</button>
                </div>
                <div class="modal-body">
                    <p class="small">Available Cashback Balance: 
                        <strong>₱<span id="availableCashback">{{ number_format($cashbackBalance, 2) }}</span></strong>
                    </p>

                    <div class="form-group mb-3">
                        <label for="cashbackAmount">Amount to Transfer</label>
                        <input 
                            type="number" 
                            class="form-control" 
                            id="cashbackAmount" 
                            name="amount"
                            min="1" 
                            max="{{ $cashbackBalance }}"
                            step="0.01"
                            value="{{ old('amount') }}" 
                            required
                        >
                        @error('amount')
                            <small class="text-danger">{{ $message }}</small>
                        @enderror
                        <small id="cashbackAmountError" class="text-danger d-none">
                            Please enter a valid amount not exceeding your cashback balance.
                        </small>
                    </div>

                    <div class="mt-3 small">
                        <p class="mb-1 text-muted">0% Transaction muna tayo!: 
                            <strong>₱<span id="cashbackFee">0.00</span></strong>
                        </p>
                        <p class="mb-0">Net to Receive: 
                            <strong class="text-success">₱<span id="cashbackNet">0.00</span></strong>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button 
                        type="button" 
                        class="btn btn-secondary" 
                        data-bs-dismiss="modal"
                    >
                        Cancel
                    </button>
                    <button 
                        type="submit" 
                        class="btn btn-primary" 
                        id="confirmCashbackTransferBtn" 
                        disabled
                    >
                        Confirm Transfer
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection
@include('partials.mobile-footer')

@push('js')
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const amountInput = document.getElementById('cashbackAmount');
    const feeDisplay = document.getElementById('cashbackFee');
    const netDisplay = document.getElementById('cashbackNet');
    const submitBtn = document.getElementById('confirmCashbackTransferBtn');
    const errorText = document.getElementById('cashbackAmountError');
    const availableBalance = parseFloat({{ $cashbackBalance }});

    function validateAndCalculate() {
        const amount = parseFloat(amountInput.value);
        let isValid = true;

        if (isNaN(amount) || amount <= 0 || amount > availableBalance) {
            isValid = false;
        }

        if (!isValid) {
            errorText.classList.remove('d-none');
            amountInput.classList.add('is-invalid');
            submitBtn.disabled = true;
            feeDisplay.textContent = '0.00';
            netDisplay.textContent = '0.00';
        } else {
            errorText.classList.add('d-none');
            amountInput.classList.remove('is-invalid');
            const fee = +(amount * 0.00).toFixed(2);
            const net = +(amount - fee).toFixed(2);
            feeDisplay.textContent = fee.toFixed(2);
            netDisplay.textContent = net.toFixed(2);
            submitBtn.disabled = false;
        }
    }

    amountInput?.addEventListener('input', validateAndCalculate);
    validateAndCalculate();

    @if($errors->any() && old('_modal') === 'cashback-transfer')
        const modal = new bootstrap.Modal(document.getElementById('cashbackTransferModal'));
        modal.show();
    @endif
});
</script>
@endpush
