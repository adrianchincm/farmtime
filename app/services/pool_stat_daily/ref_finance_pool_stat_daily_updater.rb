# frozen_string_literal: true

class RefFinancePoolStatDailyUpdater < ApplicationService  
  def initialize    
  end

  def call
    pool_stat = PoolStat.find_by(tokens: ["bitcoin", "ethereum"] , pool_owner: "Ref Finance")
    PoolStatDaily.create(name: "Ref Finance - BTC/ETH", tvl: pool_stat.tvl, apy: pool_stat.apr, coindix_id: nil)
  end
end
