require 'sidekiq-scheduler'

class UpdatePools
  include Sidekiq::Worker

  def perform
    portfolios = Portfolio.where.not(name: "demo")

    portfolios.each { |portfolio|
      OsmoUstUpdater.call(portfolio) # initial amount : 975
      LunaUstUpdater.call(portfolio) # initial amount : 520 + 560 = 1070
      AtomOsmoUpdater.call(portfolio) # atom/osmo , initial amount : 575
      LateQuartetUpdater.call(portfolio) # initial amount : 236
      BtcEthUpdater.call(portfolio) # initial amount : 100
      StethUstUpdater.call(portfolio) # initial amount : 800
      StethUstSpecFinanceUpdater.call(portfolio) # initial amount : 800
    }
  end
end