desc 'Seeds all pools to portfolio id 1'
task :seed_coin_data => :environment do
  pools = Coin.all

  pools.each do |pool|
    pool.portfolio_id = 1
    pool.save
  end
end