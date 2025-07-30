@extends('adminlte::page')

@section('title', 'My Tickets')

@section('content_header')
    <h3>Help Desk</h3>
@stop

@section('content')
    {{-- Submit Ticket Form --}}
    <div class="card mb-4">
        <div class="card-header"><strong>Submit a New Ticket</strong></div>
        <div class="card-body">
            <form action="{{ route('member.tickets.store') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" name="subject" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" rows="4" class="form-control" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Ticket</button>
            </form>
        </div>
    </div>

    {{-- List Tickets --}}
    <div class="card">
        <div class="card-header"><strong>My Tickets</strong></div>
        <div class="card-body table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($tickets as $ticket)
                        <tr>
                            <td>{{ $ticket->subject }}</td>
                            <td>
                                <span class="{{ $ticket->status_badge_class }}">
                                    {{ $ticket->status_label }}
                                </span>
                            </td>
                            <td>{{ $ticket->created_at->format('F d, Y') }}</td>
                            <td>
                                <a href="{{ route('member.tickets.show', $ticket->id) }}" class="btn btn-sm btn-info">
                                    View
                                </a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted">No tickets yet.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
@stop

@include('partials.mobile-footer')

@section('js')
    {{-- Toastr Notifications --}}
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />

    <script>
        @if(session('success'))
            toastr.success("{{ session('success') }}");
        @endif
        @if(session('error'))
            toastr.error("{{ session('error') }}");
        @endif
    </script>
@endsection
