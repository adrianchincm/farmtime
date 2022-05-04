# frozen_string_literal: true

class SpectrumFinancePoolStatDailyUpdater < ApplicationService  
  def initialize    
  end

  def call
    pool_stat = PoolStat.find_by(tokens: ["wrapped-steth", "terrausd"] , pool_owner: "Spectrum Finance")
    PoolStatDaily.create(name: "Spectrum Finance - WSTETH/UST", tvl: pool_stat.tvl, apy: pool_stat.apr, farmtime_id: "spectrum-finance-wsteth-ust")
  end
end