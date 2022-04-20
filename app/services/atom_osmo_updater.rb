# frozen_string_literal: true

class AtomOsmoUpdater < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
  end
  
    def call
      url =
        'https://api-osmosis.imperator.co/pools/v2/1'
      getAtomOsmoLiquidity = HTTParty.get(url).parsed_response
  
      totalLiquidity = (getAtomOsmoLiquidity[0]['amount'] * getAtomOsmoLiquidity[0]['price']) + (getAtomOsmoLiquidity[1]['amount'] * getAtomOsmoLiquidity[1]['price'])
  
      ##############################################################################
  
      url =
        'https://lcd-osmosis.keplr.app/osmosis/gamm/v1beta1/pools/1'
      getAtomOsmoLiquidityLPSupply = HTTParty.get(url).parsed_response
  
      totalLpTokens = getAtomOsmoLiquidityLPSupply['pool']['totalShares']['amount'].to_f / 1_000_000_000_000_000_000
  
      lpTokenValue = totalLiquidity / totalLpTokens
  
      ##############################################################################
  
      url =
        "https://lcd-osmosis.keplr.app/osmosis/lockup/v1beta1/account_locked_coins/#{@portfolio.osmosis_address}"
      getBondedLPTokens = HTTParty.get(url).parsed_response
      
      pool = getBondedLPTokens['coins'].select { |pool| pool["denom"] == 'gamm/pool/1' }
      bondedTokens = pool[0]['amount'].to_f / 1_000_000_000_000_000_000      
  
      atom_osmo_value = bondedTokens * lpTokenValue
      pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: ["cosmos", "osmosis"])
      pool.current_price = atom_osmo_value
      pool.save
    end
  end
  