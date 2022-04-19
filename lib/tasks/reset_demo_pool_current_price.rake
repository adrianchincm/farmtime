desc 'reset demo pool current price to 1234.56'
task :reset_demo_pool_current_price => :environment do
  portfolio = Portfolio.find_by(name: "demo")
  demo_pools = Pool.where(portfolio_id: portfolio.id)

  demo_pools.each do |pool|
    pool.current_price = 1234.56
    pool.save
  end
end