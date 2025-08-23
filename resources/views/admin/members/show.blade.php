@extends('adminlte::page')

@section('title', 'Member Details')

@section('content_header')
    <h1>Member Details</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Member Information</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <table class="table table-borderless">
                        <tr>
                            <th>Name:</th>
                            <td>{{ $member->first_name }} {{ $member->middle_name }} {{ $member->last_name }}</td>
                        </tr>
                        <tr>
                            <th>Birthday:</th>
                            <td>{{ $member->birthday->format('F j, Y') }}</td>
                        </tr>
                        <tr>
                            <th>Mobile Number:</th>
                            <td>{{ $member->mobile_number }}</td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>{{ $member->user->email ?? 'N/A' }}</td>
                        </tr>
                        <tr>
                            <th>Occupation:</th>
                            <td>{{ $member->occupation ?? 'N/A' }}</td>
                        </tr>
                        <tr>
                            <th>Address:</th>
                            <td>{{ $member->address ?? 'N/A' }}</td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <table class="table table-borderless">
                        <tr>
                            <th>Role:</th>
                            <td>
                                @if($member->role === 'Admin')
                                    <span class="badge bg-danger">{{ $member->role }}</span>
                                @elseif($member->role === 'Staff')
                                    <span class="badge bg-warning">{{ $member->role }}</span>
                                @else
                                    <span class="badge bg-success">{{ $member->role }}</span>
                                @endif
                            </td>
                        </tr>
                        <tr>
                            <th>Status:</th>
                            <td>
                                @if($member->status === 'Active')
                                    <span class="badge bg-success">{{ $member->status }}</span>
                                @elseif($member->status === 'Pending')
                                    <span class="badge bg-warning">{{ $member->status }}</span>
                                @else
                                    <span class="badge bg-secondary">{{ $member->status }}</span>
                                @endif
                            </td>
                        </tr>
                        <tr>
                            <th>Sponsor:</th>
                            <td>
                                @if($member->sponsor)
                                    {{ $member->sponsor->first_name }} {{ $member->sponsor->last_name }}
                                @else
                                    No Sponsor
                                @endif
                            </td>
                        </tr>
                        <tr>
                            <th>Loan Eligible:</th>
                            <td>
                                @if($member->loan_eligible)
                                    <span class="badge bg-success">Yes</span>
                                @else
                                    <span class="badge bg-secondary">No</span>
                                @endif
                            </td>
                        </tr>
                        <tr>
                            <th>Created At:</th>
                            <td>{{ $member->created_at->format('F j, Y g:i A') }}</td>
                        </tr>
                        <tr>
                            <th>Updated At:</th>
                            <td>{{ $member->updated_at->format('F j, Y g:i A') }}</td>
                        </tr>
                    </table>
                </div>
            </div>

            @if($member->photo)
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h5>Photo:</h5>
                        <img src="{{ $member->photo_url }}" alt="Member Photo" class="img-thumbnail" style="max-width: 200px;">
                    </div>
                </div>
            @endif
        </div>
        <div class="card-footer">
            <a href="{{ route('members.index') }}" class="btn btn-secondary">Back to Members</a>
            <a href="{{ route('members.edit', $member->id) }}" class="btn btn-primary">Edit Member</a>
        </div>
    </div>
@stop
