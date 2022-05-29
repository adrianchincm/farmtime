require 'sidekiq-scheduler'

class UpdatePools
  include Sidekiq::Worker

  def perform
    portfolios = Portfolio.where.not(name: "demo")

    portfolios.each { |portfolio|
      OsmoUstUpdater.call(portfolio)
      LunaUstUpdater.call(portfolio)
      AtomOsmoUpdater.call(portfolio)
      LateQuartetUpdater.call(portfolio)
      BtcEthUpdater.call(portfolio)
      StethUstUpdater.call(portfolio)
      StethUstSpecFinanceUpdater.call(portfolio) 
    }
  end
end