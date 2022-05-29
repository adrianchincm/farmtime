# frozen_string_literal: true

class OsmoUstUpdater < ApplicationService
    def initialize(portfolio)
      @portfolio = portfolio
    end
  
    def call
      url =
        'https://api-osmosis.imperator.co/pools/v2/560'
      getOsmoUstLiquidity = HTTParty.get(url).parsed_response
  
      totalLiquidity = (getOsmoUstLiquidity[0]['amount'] * getOsmoUstLiquidity[0]['price']) + (getOsmoUstLiquidity[1]['amount'] * getOsmoUstLiquidity[1]['price'])
  
      ##############################################################################
  
      url =
        'https://lcd-osmosis.keplr.app/osmosis/gamm/v1beta1/pools/560'
      getOsmoUstLiquidityLPSupply = HTTParty.get(url).parsed_response
  
      totalLpTokens = getOsmoUstLiquidityLPSupply['pool']['totalShares']['amount'].to_f / 1_000_000_000_000_000_000
  
      lpTokenValue = totalLiquidity / totalLpTokens
  
      ##############################################################################
  
      url =
        "https://lcd-osmosis.keplr.app/osmosis/lockup/v1beta1/account_locked_coins/#{@portfolio.osmosis_address}"
      getBondedLPTokens = HTTParty.get(url).parsed_response
      
      pool = getBondedLPTokens['coins'].select { |pool| pool["denom"] == 'gamm/pool/560' }
      if pool[0].present?
        bondedTokens = pool[0]['amount'].to_f / 1_000_000_000_000_000_000      
  
        osmo_ust_value = bondedTokens * lpTokenValue
        
        pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: ["osmosis", "terrausd"])
        pool.current_price = osmo_ust_value
        pool.save
      end      
    end
  end
  