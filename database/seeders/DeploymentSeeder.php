<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Member;
use App\Models\Wallet;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\WalletTransaction;
use App\Models\CashbackLog;
use App\Models\ReferralBonusLog;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class DeploymentSeeder extends Seeder
{
    /**
     * Run the database seeds to prepare for deployment.
     * Clears most data and retains only the Super Admin account.
     *
     * @return void
     */
    public function run()
    {
        // Begin transaction to ensure all operations succeed or fail together
        DB::transaction(function () {
            $now = Carbon::now();
            
            // Clear existing data
            $this->clearExistingData();
            
            // Create Super Admin
            $adminMember = Member::firstOrCreate(
                ['mobile_number' => '09177260180'],
                [
                    'first_name'     => 'Super',
                    'middle_name'    => '',
                    'last_name'      => 'Admin',
                    'birthday'       => '1990-01-01',
                    'occupation'     => 'Administrator',
                    'address'        => 'Admin HQ',
                    'photo'          => 'default-profile.png',
                    'role'           => 'Admin',
                    'status'         => 'Approved',
                    'loan_eligible'  => true,
                    'created_at'     => $now,
                    'updated_at'     => $now,
                ]
            );
            
            User::firstOrCreate(
                ['mobile_number' => '09177260180'],
                [
                    'name'              => 'Super Admin',
                    'email'             => 'admin@ebili.com',
                    'role'              => 'Admin',
                    'member_id'         => $adminMember->id,
                    'email_verified_at' => $now,
                    'password'          => Hash::make('password123'),
                    'status'            => 'Approved',
                    'created_at'        => $now,
                    'updated_at'        => $now,
                ]
            );
            
            // Create wallets for admin
            foreach (['main', 'cashback'] as $type) {
                Wallet::firstOrCreate([
                    'member_id' => $adminMember->id,
                    'type'      => $type,
                ], [
                    'wallet_id'  => 'WALLET-' . strtoupper(uniqid()),
                    'balance'    => 0,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]);
            }
            
            $this->command->info('✅ Deployment preparation completed. Super Admin account retained, all other data cleared.');
        });
    }
    
    /**
     * Clear existing data while preserving system settings.
     */
    private function clearExistingData()
    {
        // Disable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=0');
        
        try {
            // Delete all cashback logs
            $this->command->info('Clearing cashback logs...');
            CashbackLog::query()->delete();
            
            // Delete all referral bonus logs
            $this->command->info('Clearing referral bonus logs...');
            ReferralBonusLog::query()->delete();
            
            // Delete all wallet transactions
            $this->command->info('Clearing wallet transactions...');
            WalletTransaction::query()->delete();
            
            // Delete all order items
            $this->command->info('Clearing order items...');
            OrderItem::query()->delete();
            
            // Delete all orders
            $this->command->info('Clearing orders...');
            Order::query()->delete();
            
            // Clear users and members except the Super Admin
            $this->command->info('Clearing users except Super Admin...');
            User::where('mobile_number', '!=', '09177260180')->delete();
            
            $this->command->info('Clearing members except Super Admin...');
            Member::where('mobile_number', '!=', '09177260180')->delete();
            
            // Reset wallets for remaining members
            $this->command->info('Resetting wallets...');
            Wallet::whereNotIn('member_id', function($query) {
                $query->select('id')->from('members');
            })->delete();
            
            // Update all remaining members to have role 'Member' except the Super Admin
            $this->command->info('Updating member roles...');
            Member::where('mobile_number', '!=', '09177260180')
                  ->update(['role' => 'Member']);
            
            // Update all remaining users to have role 'Member' except the Super Admin
            $this->command->info('Updating user roles...');
            User::where('mobile_number', '!=', '09177260180')
                ->update(['role' => 'Member']);
                
            $this->command->info('✅ Existing data cleared successfully.');
        } finally {
            // Re-enable foreign key checks
            DB::statement('SET FOREIGN_KEY_CHECKS=1');
        }
    }
}