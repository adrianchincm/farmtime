require 'sidekiq-scheduler'

class SnapSevenDayAverage
  include Sidekiq::Worker

  def perform()    
    pool_stats = PoolStat.all
    pool_stats.each do |pool_stat|
        pool_stat_dailies = []
        if pool_stat.coindix_id.nil?
            pool_stat_dailies = PoolStatDaily.last_7_days.where(farmtime_id: pool_stat.farmtime_id)
        else
            pool_stat_dailies = PoolStatDaily.last_7_days.where(coindix_id: pool_stat.coindix_id)
        end
        
        if pool_stat_dailies.empty?
          pool_stat.tvl_7d_average = pool_stat.tvl
          pool_stat.apy_7d_average = pool_stat.apr
        else
          pool_stat.tvl_7d_average = pool_stat_dailies.sum(&:tvl) / pool_stat_dailies.size
          pool_stat.apy_7d_average = pool_stat_dailies.sum(&:apy) / pool_stat_dailies.size
        end        
        pool_stat.save
    end
  end
end