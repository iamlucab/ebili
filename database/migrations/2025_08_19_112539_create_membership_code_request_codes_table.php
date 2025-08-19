<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('membership_code_request_codes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('membership_code_request_id');
            $table->unsignedBigInteger('membership_code_id');
            $table->timestamp('reserved_at')->nullable();
            $table->timestamp('assigned_at')->nullable();
            $table->timestamps();

            $table->foreign('membership_code_request_id')->references('id')->on('membership_code_requests')->onDelete('cascade');
            $table->foreign('membership_code_id')->references('id')->on('membership_codes')->onDelete('cascade');

            $table->unique(['membership_code_request_id', 'membership_code_id'], 'mcr_codes_unique');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('membership_code_request_codes');
    }
};
