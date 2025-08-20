@extends('adminlte::page')

@section('title', 'Membership Code Requests')

@section('content_header')
    <h5>Membership Code Requests</h5>
@stop

@section('content')
<div class="container-fluid">
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    @if(session('error'))
        <div class="alert alert-danger">
            {{ session('error') }}
        </div>
    @endif

    <div class="card">
        <div class="card-header">
            <h6 class="card-title" style="color:white !important ">Membership Code Requests</h6>
        </div>
        <div class="card-body">
            @if($requests->count() > 0)
                <div class="table-responsive">
                    <table id="membershipCodeRequestsTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>Request ID</th>
                                <th>Member</th>
                                <th>Mobile Number</th>
                                <th>Quantity</th>
                                <th>Reserved Codes</th>
                                <th>Amount per Code</th>
                                <th>Total Amount</th>
                                <th>Payment Method</th>
                                <th>Status</th>
                                <th>Requested At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($requests as $request)
                                <tr>
                                    <td>{{ $request->id }}</td>
                                    <td>{{ $request->member->full_name ?? 'N/A' }}</td>
                                    <td>{{ $request->member->mobile_number ?? 'N/A' }}</td>
                                    <td>{{ $request->quantity }}</td>
                                    <td>{{ $request->reserved_codes_count ?? 0 }}</td>
                                    <td>₱{{ number_format($request->amount_per_code, 2) }}</td>
                                    <td>₱{{ number_format($request->total_amount, 2) }}</td>
                                    <td>{{ $request->payment_method }}</td>
                                    <td>
                                        @if($request->status === 'pending')
                                            <span class="badge badge-warning">Pending</span>
                                        @elseif($request->status === 'approved')
                                            <span class="badge badge-success">Approved</span>
                                        @elseif($request->status === 'rejected')
                                            <span class="badge badge-danger">Rejected</span>
                                        @elseif($request->status === 'cancelled')
                                            <span class="badge badge-secondary">Cancelled</span>
                                        @endif
                                    </td>
                                    <td>{{ $request->created_at->format('M d, Y H:i') }}</td>
                                    <td>
                                        @if($request->proof_path)
                                            <button class="btn btn-sm btn-info mb-1" data-toggle="modal" data-target="#proofModal{{ $request->id }}">
                                                <i class="bi bi-image"></i> View Proof
                                            </button>
                                        @endif

                                        @if($request->status === 'pending')
                                            <form action="{{ route('admin.membership-code-requests.approve', $request) }}" method="POST" class="d-inline">
                                                @csrf
                                                <button type="submit" class="btn btn-sm btn-success mb-1" onclick="return confirm('Are you sure you want to approve this request? This will automatically generate codes.')">
                                                    <i class="bi bi-check-circle"></i> Auto Approve
                                                </button>
                                            </form>

                                            <form action="{{ route('admin.membership-code-requests.reject', $request) }}" method="POST" class="d-inline">
                                                @csrf
                                                <button type="submit" class="btn btn-sm btn-danger mb-1" onclick="return confirm('Are you sure you want to reject this request?')">
                                                    <i class="bi bi-x-circle"></i> Reject
                                                </button>
                                            </form>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            @else
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> No membership code requests found.
                </div>
            @endif
        </div>
    </div>

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <!-- PWA Manifest -->
    <link rel="manifest" href="/manifest.json">
    <!-- PWA Meta Tags -->
    <meta name="theme-color" content="#4e73df"/>
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="Membership Codes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
</div>
@stop

{{-- Proof Modals --}}
@foreach($requests as $request)
    @if($request->proof_path)
        <div class="modal" id="proofModal{{ $request->id }}" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Payment Proof</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body text-center">
                        <img src="{{ asset('storage/' . $request->proof_path) }}" class="img-fluid" alt="Payment Proof">
                        <br><br>
                        <a href="{{ asset('storage/' . $request->proof_path) }}" download class="btn btn-sm btn-secondary">
                            Download
                        </a>
                    </div>
                </div>
            </div>
        </div>
    @endif

@endforeach

@section('css')
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
@stop

@section('js')
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<script>
    $(document).ready(function() {
        $('#membershipCodeRequestsTable').DataTable({
            "pageLength": 25,
            "order": [[ 0, "desc" ]],
            "responsive": true,
            "autoWidth": false,
        });
    });

</script>
@stop

@include('partials.mobile-footer')
