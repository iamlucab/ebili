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
        Schema::table('membership_codes', function (Blueprint $table) {
            $table->boolean('reserved')->default(false)->after('used');
            $table->unsignedBigInteger('reserved_by')->nullable()->after('reserved');
            $table->foreign('reserved_by')->references('id')->on('membership_code_requests')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('membership_codes', function (Blueprint $table) {
            $table->dropForeign(['reserved_by']);
            $table->dropColumn(['reserved', 'reserved_by']);
        });
    }
};
