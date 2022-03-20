# frozen_string_literal: true

class OsmoUstUpdater < ApplicationService
    def initialize; end
  
    def call
      url =
        'https://api-osmosis.imperator.co/pools/v1/560'
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
        'https://lcd-osmosis.keplr.app/osmosis/lockup/v1beta1/account_locked_coins/osmo10l6e5ch3px3vavqgx5qmee82v0jhwl6wu6tt33'
      getBondedLPTokens = HTTParty.get(url).parsed_response
      
      pool = getBondedLPTokens['coins'].select { |pool| pool["denom"] == 'gamm/pool/560' }
      bondedTokens = pool[0]['amount'].to_f / 1_000_000_000_000_000_000      
  
      osmo_ust_value = bondedTokens * lpTokenValue

      pool = Pool.find_by(tokens: ["osmosis", "ust"])
      pool.current_price = osmo_ust_value
      pool.save
    end
  end
  