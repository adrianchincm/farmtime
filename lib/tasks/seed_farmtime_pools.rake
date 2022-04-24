desc 'Seed farmtime pools'
task :seed_farmtime_pools => :environment do    
    ref_finance_btc_eth_pool_stat = PoolStat.find_by(tokens: ["bitcoin", "ethereum"], pool_owner: "Ref Finance")
    ref_finance_btc_eth_pool_stat.farmtime_id = "ref-finance-btc-eth"
    ref_finance_btc_eth_pool_stat.save

    ref_finance_btc_eth_pool_stat_dailies = PoolStatDaily.where(name: "Ref Finance - BTC/ETH")
    ref_finance_btc_eth_pool_stat_dailies.each do |daily|
        daily.farmtime_id = "ref-finance-btc-eth"
        daily.save
    end
end