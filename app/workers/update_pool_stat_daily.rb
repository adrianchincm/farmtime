require 'sidekiq-scheduler'

class UpdatePoolStatDaily
  include Sidekiq::Worker

  def perform
    CoindixPoolStatDailyUpdater.call()    
  end
end