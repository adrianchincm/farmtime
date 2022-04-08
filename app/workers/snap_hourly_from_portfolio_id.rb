require 'sidekiq-scheduler'

class SnapHourlyFromPortfolioId
  include Sidekiq::Worker

  def perform(portfolio_id)
    pools = Pool.where(portfolio_id: portfolio_id)
    pools.each do |pool|
      PoolHourly.create(pool_id: pool.id, current_price: pool.current_price, portfolio_id: portfolio_id)
    end    
  end
end