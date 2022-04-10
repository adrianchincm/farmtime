require 'sidekiq-scheduler'

class SnapDaily
  include Sidekiq::Worker

  def perform()
    portfolios = Portfolio.where.not(name: "demo")
    portfolios.each do |portfolio|
      SnapDailyFromPortfolioId.perform_async(portfolio.id)
    end    
  end
end