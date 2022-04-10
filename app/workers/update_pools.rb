require 'sidekiq-scheduler'

class UpdatePools
  include Sidekiq::Worker

  def perform
    portfolios = Portfolio.where.not(name: "demo")

    portfolios.each { |portfolio|
      OsmoUstUpdater.call(portfolio.osmosis_address) # initial amount : 975
      LunaUstUpdater.call(portfolio.osmosis_address) # initial amount : 520 + 560 = 1070
      AtomOsmoUpdater.call(portfolio.osmosis_address) # atom/osmo , initial amount : 575
      LateQuartetUpdater.call(portfolio.fantom_address) # initial amount : 236
      BtcEthUpdater.call(portfolio.ref_finance_shares["btceth"]) # initial amount : 100
      StethUstUpdater.call(portfolio.terra_address) # initial amount : 800
    }    
  end
end