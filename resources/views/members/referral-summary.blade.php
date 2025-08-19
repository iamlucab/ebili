@extends('layouts.adminlte-base')
@section('title', 'My Referral Network')

{{-- E-Bili Theme Styling --}}
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="{{ asset('css/ebili-theme.css') }}">

@section('content_header')
<div class="text-center mb-4 fade-in">
    <h2 class="fw-bold mb-2" style="color: var(--primary-purple);">My Referral Network</h2>
    <p class="text-muted mb-0">Track your downline and referral bonuses</p>
</div>
@stop

@section('css')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
<style>
    .level-card {
        transition: all 0.3s ease;
        border-left: 4px solid transparent;
    }
    .level-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .level-1 { border-left-color: #28a745; }
    .level-2 { border-left-color: #17a2b8; }
    .level-3 { border-left-color: #ffc107; }
    .level-4 { border-left-color: #fd7e14; }
    .level-5 { border-left-color: #dc3545; }
    .level-6 { border-left-color: #6f42c1; }
    .level-7 { border-left-color: #e83e8c; }
    .level-8 { border-left-color: #20c997; }
    .level-9 { border-left-color: #6c757d; }
    .level-10 { border-left-color: #343a40; }
    .level-11 { border-left-color: #007bff; }

    .stats-card {
        background: linear-gradient(135deg, #6f42c1 0%, #8e44ad 100%);
        color: white;
        border: none;
    }

    .filter-card {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
    }

    .member-item {
        transition: all 0.2s ease;
    }
    .member-item:hover {
        background-color: #f8f9fa;
        border-radius: 8px;
    }

    .collapse-toggle {
        cursor: pointer;
        transition: transform 0.2s ease;
    }
    .collapse-toggle.collapsed {
        transform: rotate(-90deg);
    }

    /* Pagination improvements to prevent overlapping */
    .pagination-wrapper {
        display: flex;
        justify-content: center;
        margin: 1.5rem 0;
        overflow-x: auto;
        padding: 0 10px;
        max-width: 100%;
    }

    .pagination-container {
        display: inline-block;
        max-width: 100%;
        overflow-x: auto;
        padding: 10px 0;
        margin: 0 auto;
    }

    /* Ensure pagination doesn't overlap with other elements */
    .pagination-container ul {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        margin: 0;
        padding: 0;
        list-style: none;
        max-width: 100%;
        overflow-x: auto;
        white-space: nowrap;
    }

    .pagination-container li {
        margin: 0 2px;
        flex: 0 0 auto;
    }

    /* Responsive pagination for mobile */
    @media (max-width: 768px) {
        .pagination-wrapper {
            padding: 0 5px;
        }

        .pagination-container ul {
            font-size: 0.85rem;
        }

        .pagination-container .page-link {
            padding: 8px 12px;
            min-width: 36px;
        }
    }

    /* Ensure no overlap with footer or other elements */
    .pagination-wrapper + * {
        margin-top: 1rem;
    }

    /* Additional styles for the custom pagination */
    .ebili-pagination {
        display: flex;
        justify-content: center;
        width: 100%;
        margin: 1.5rem 0;
        clear: both;
    }

    .pagination-controls {
        width: 100%;
        max-width: 100%;
        overflow: hidden;
    }
</style>
@endsection

@section('content')
<div class="container-fluid px-2">

    {{-- Summary Stats Cards --}}
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="bi bi-people-fill fa-2x mb-2"></i>
                    <h4 class="fw-bold">{{ $totalReferrals }}</h4>
                    <small>Total Referrals</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="bi bi-cash-coin fa-2x mb-2"></i>
                    <h4 class="fw-bold">₱{{ number_format($totalBonusEarned, 2) }}</h4>
                    <small>Total Bonus Earned</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="bi bi-graph-up fa-2x mb-2"></i>
                    <h4 class="fw-bold">{{ count($referralData) }}</h4>
                    <small>Active Levels</small>
                </div>
            </div>
        </div>
    </div>

    {{-- Filter Form --}}
    <div class="card filter-card mb-4">
        <div class="card-body">
            <form method="GET" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Start Date</label>
                    <input type="date" name="start_date" value="{{ $startDate }}" class="form-control">
                </div>
                <div class="col-md-3">
                    <label class="form-label">End Date</label>
                    <input type="date" name="end_date" value="{{ $endDate }}" class="form-control">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Level Filter</label>
                    <select name="level" class="form-control">
                        <option value="all" {{ $selectedLevel == 'all' ? 'selected' : '' }}>All Levels</option>
                        @for($i = 1; $i <= 11; $i++)
                            <option value="{{ $i }}" {{ $selectedLevel == $i ? 'selected' : '' }}>Level {{ $i }}</option>
                        @endfor
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">&nbsp;</label>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-funnel me-1"></i>Filter
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {{-- Referral Levels --}}
    <div class="row">
        @forelse($referralData as $levelData)
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card level-card level-{{ $levelData['level'] }}">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 fw-bold text-white">
                            <i class="bi bi-diagram-{{ min($levelData['level'], 3) }} me-2"></i>
                            Level {{ $levelData['level'] }}
                        </h6>
                        <span class="badge bg-primary">{{ $levelData['count'] }} members</span>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3">
                            <div>
                                <small class="text-muted">Referrals</small>
                                <div class="fw-bold">{{ $levelData['count'] }}</div>
                            </div>
                            <div class="text-end">
                                <small class="text-muted">Bonus Earned</small>
                                <div class="fw-bold text-success">₱{{ number_format($levelData['bonus_earned'], 2) }}</div>
                            </div>
                        </div>

                        @if($levelData['count'] > 0)
                            <!--<button class="btn btn-outline-primary btn-sm w-100" -->
                            <!--        type="button" -->
                            <!--        data-bs-toggle="collapse" -->
                            <!--        data-bs-target="#level{{ $levelData['level'] }}Details" -->
                            <!--        aria-expanded="false">-->
                            <!--    <i class="bi bi-chevron-down collapse-toggle me-1"></i>-->
                            <!--    View Members-->
                            <!--</button>-->

                            <div class="collapse mt-3" id="level{{ $levelData['level'] }}Details">
                                <div class="border-top pt-3">
                                    @foreach($levelData['referrals'] as $referral)
                                        <div class="member-item p-2 mb-2">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <div class="fw-bold">{{ $referral->full_name }}</div>
                                                    <small class="text-muted">
                                                        <i class="bi bi-phone me-1"></i>{{ $referral->mobile_number }}
                                                    </small>
                                                    <br>
                                                    <small class="text-muted">
                                                        <i class="bi bi-calendar me-1"></i>{{ $referral->created_at->format('M d, Y') }}
                                                    </small>
                                                </div>
                                                <span class="badge bg-{{ $referral->status == 'Approved' ? 'success' : 'warning' }}">
                                                    {{ $referral->status }}
                                                </span>
                                            </div>
                                        </div>
                                    @endforeach
                                </div>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        @empty
            <div class="col-12">
                <div class="card">
                    <div class="card-body text-center py-5">
                        <i class="bi bi-people fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No referrals found</h5>
                        <p class="text-muted">Start referring friends to build your network!</p>
                        <a href="{{ route('member.register.form') }}" class="btn btn-primary">
                            <i class="bi bi-person-plus me-1"></i>Refer Someone
                        </a>
                    </div>
                </div>
            </div>
        @endforelse
    </div>

    {{-- Recent Activity --}}
    @if($recentBonusLogs->count() > 0)
        <div class="card mt-4">
            <div class="card-header text-white">
                <h6 class="mb-0">
                    <i class="bi bi-clock-history text-white me-2"></i> <font color="white"> Recent Bonus Activity
                </h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-sm" id="bonusActivityTable">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Level</th>
                                <th>From</th>
                                <th>Amount</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($recentBonusLogs as $log)
                                <tr>
                                    <td class="text-purple">{{ $log->created_at->format('M d, Y') }}</td>
                                    <td><span class="badge bg-info">Level {{ $log->level }}</span></td>
                                    <td>
                                        <div class="text-purple">{{ $log->referredMember->full_name ?? 'N/A' }}</div>
                                        <small class="text-muted">{{ $log->referredMember->mobile_number ?? '' }}</small>
                                    </td>
                                    <td class="text-success fw-bold">₱{{ number_format($log->amount, 2) }}</td>
                                    <td><small>{{ $log->description }}</small></td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
</div>
                <div class="ebili-pagination mt-3">
                    <div class="pagination-controls">
                        {{ $recentBonusLogs->onEachSide(1)->links('vendor.pagination.ebili-pagination') }}
                    </div>
                </div>
        </div>
    @endif

</div>
@stop

<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
@section('js')
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Handle collapse toggle icon rotation
    document.querySelectorAll('[data-bs-toggle="collapse"]').forEach(function(element) {
        element.addEventListener('click', function() {
            const icon = this.querySelector('.collapse-toggle');
            if (icon) {
                icon.classList.toggle('collapsed');
            }
        });
    });

    // Auto-submit form when date changes
    document.querySelectorAll('input[type="date"], select[name="level"]').forEach(function(element) {
        element.addEventListener('change', function() {
            // Optional: Auto-submit form on change
            // this.form.submit();
        });
    });
});

// Success/Error Messages
@if(session('success'))
    toastr.success("{{ session('success') }}");
@endif

@if(session('error'))
    toastr.error("{{ session('error') }}");
@endif

    // Initialize DataTables for bonus activity table (with server-side pagination)
    $('#bonusActivityTable').DataTable({
        "paging": false, // Disable client-side pagination since we're using server-side
        "info": false, // Disable info since we're using server-side pagination
        "order": [[0, "desc"]], // Order by date (first column) descending
        "language": {
            "zeroRecords": "No matching records found",
            "search": "Search:",
        }
    });

</script>
@endsection

{{-- Mobile Footer --}}
@include('partials.mobile-footer')
