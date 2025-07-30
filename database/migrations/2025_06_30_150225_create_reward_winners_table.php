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
     Schema::create('reward_winners', function (Blueprint $table) {
    $table->id();
    $table->foreignId('reward_program_id')->constrained()->onDelete('cascade');
    $table->foreignId('member_id')->constrained()->onDelete('cascade');
    $table->timestamp('drawn_at');
    $table->date('excluded_until');
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reward_winners');
    }
};
