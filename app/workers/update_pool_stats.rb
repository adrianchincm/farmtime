require 'sidekiq-scheduler'

class UpdatePoolStats
  include Sidekiq::Worker

  def perform
    CoindixStatsUpdater.call()
    RefFinanceBtcEthUpdater.call()
  end
end