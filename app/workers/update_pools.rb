require 'sidekiq-scheduler'

class UpdatePools
  include Sidekiq::Worker

  def perform

   OsmoUstUpdater.call() # initial amount : 975
   LunaUstUpdater.call() # initial amount : 520 + 560 = 1070
   AtomOsmoUpdater.call() # atom/osmo , initial amount : 575
   LateQuartetUpdater.call() # initial amount : 236
  end
end