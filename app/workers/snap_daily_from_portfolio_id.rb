require 'sidekiq-scheduler'

class SnapDailyFromPortfolioId
  include Sidekiq::Worker

  def perform(portfolio_id)
    yesterday = Date.today - 1
    pools = Pool.where(portfolio_id: portfolio_id)
    pools.each do |pool|
        hourlies = PoolHourly.where(created_at: yesterday.beginning_of_day..yesterday.end_of_day, pool_id: pool.id)
        if hourlies.empty?
          daily_average = Pool.find_by(id: pool.id, portfolio_id: portfolio_id).current_price
        else
          daily_average = hourlies.sum(&:current_price) / hourlies.size
        end
        PoolDaily.create(pool_id: pool.id, current_price: daily_average, portfolio_id: portfolio_id)
    end
  end
end