require 'sidekiq-scheduler'

class UpdateWallets
  include Sidekiq::Worker

  def perform()
    portfolios = Portfolio.where.not(name: "demo")
    portfolios.each do |portfolio|
        BinanceWalletUpdater.call(portfolio)
    end    
  end
end