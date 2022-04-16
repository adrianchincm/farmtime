require 'sidekiq-scheduler'

class UpdatePools
  include Sidekiq::Worker

  def perform
    CoindixStatsUpdater.call()
    RefFinanceBtcEthUpdater.call()
  end
end