require 'sidekiq-scheduler'

class UpdatePoolStatDaily
  include Sidekiq::Worker

  def perform
    CoindixPoolStatDailyUpdater.call()
    NonCoindixPoolStatDailyUpdater.call()
  end
end