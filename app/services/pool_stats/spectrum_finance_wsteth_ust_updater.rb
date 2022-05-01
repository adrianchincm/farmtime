# frozen_string_literal: true

class SpectrumFinanceWstethUstUpdater < ApplicationService
    def initialize            
      @tokens = %w[wrapped-steth terrausd]
      @pool_owner = "Spectrum Finance"
    end  
  
    def call
      url =
        'https://specapi.azurefd.net/api/data?type=lpVault'
      get_spec_finance_pools = HTTParty.get(url).parsed_response
  
      wsteth_ust_pool = get_spec_finance_pools["stat"]["pairs"]["Astroport|terra133chr09wu8sakfte5v7vd8qzq9vghtkv4tn0ur|uusd"]

      total_liquidity = wsteth_ust_pool["tvl"].to_f / 1000000
      apr = (wsteth_ust_pool["poolApy"] + wsteth_ust_pool["specApr"]) * 100    

      pool_stat = PoolStat.find_by(tokens: @tokens, pool_owner: @pool_owner)
      
      pool_stat.apr = apr
      pool_stat.tvl = total_liquidity
      pool_stat.save             
    end
  end
  