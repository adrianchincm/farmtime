require 'sidekiq-scheduler'

class SnapHourly
  include Sidekiq::Worker

  def perform()
    portfolios = Portfolio.all
    portfolios.each do |portfolio|
      SnapHourlyFromPortfolioId.perform_async(portfolio.id)
    end    
  end
end