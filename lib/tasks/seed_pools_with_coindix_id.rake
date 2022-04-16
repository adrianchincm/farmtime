desc 'Seed pools with coindix id'
task :seed_pools_with_coindix_id => :environment do
    pools = Pool.all

    pools.each do |pool|
      pool_stat = PoolStat.find_by(tokens: pool.tokens, pool_owner: pool.pool_owner)
      unless pool_stat == nil
        pool.pool_stat_id = pool_stat.id
        pool.save
      end      
    end
end