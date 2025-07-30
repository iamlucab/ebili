@extends('adminlte::page')

{{-- Include logout form in all AdminLTE pages --}}
@section('adminlte_js')
    @parent
    @include('partials.logout-form')
@stop

{{-- Ensure CSRF token is available --}}
@section('adminlte_css_pre')
    @parent
    <meta name="csrf-token" content="{{ csrf_token() }}">
@stop