<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // Essential seeders for system functionality
        $this->call([
            CategorySeeder::class,
            UnitSeeder::class,
            SettingSeeder::class,
            ReferralConfigurationSeeder::class,
        ]);
        
        // Deployment seeder - clears test data and creates Super Admin
        $this->call(DeploymentSeeder::class);
    }
}
