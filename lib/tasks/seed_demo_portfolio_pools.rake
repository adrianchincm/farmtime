desc 'Creates demo portfolio and pools'
task :seed_demo_portfolio_pools => :environment do
  pools = Pool.where(portfolio_id: 1)

  pools.each do |pool|
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 01 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 02 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 03 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 04 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 05 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 06 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 07 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: 1, created_at: "Wed, 08 Apr 2022 14:34:50.557931000 UTC +00:00")    
  end
end