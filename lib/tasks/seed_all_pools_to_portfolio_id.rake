desc 'Seeds all pools to portfolio id 1'
task :seed_pool_portfolio_id => :environment do
  pools = Pool.all

  pools.each do |pool|
    pool.portfolio_id = 1
    pool.save
  end
end