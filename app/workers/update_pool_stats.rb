require 'sidekiq-scheduler'

class UpdatePoolStats
  include Sidekiq::Worker

  def perform
    CoindixStatsUpdater.call()
    RefFinanceBtcEthUpdater.call()
    SpectrumFinanceWstethUstUpdater.call()
  end
end