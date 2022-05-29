# frozen_string_literal: true

class LunaUstUpdater < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    url =
      'https://api-osmosis.imperator.co/pools/v2/562'
    getLunaUstLiquidity = HTTParty.get(url).parsed_response

    totalLiquidity = (getLunaUstLiquidity[0]['amount'] * getLunaUstLiquidity[0]['price']) + getLunaUstLiquidity[1]['amount']

    ##############################################################################

    url =
      'https://lcd-osmosis.keplr.app/osmosis/gamm/v1beta1/pools/562'
    getLunaUstLPTokens = HTTParty.get(url).parsed_response

    totalLpTokens = getLunaUstLPTokens['pool']['totalShares']['amount'].to_f / 1_000_000_000_000_000_000

    lpTokenValue = totalLiquidity / totalLpTokens

    ##############################################################################

    url =
      "https://lcd-osmosis.keplr.app/osmosis/lockup/v1beta1/account_locked_coins/#{@portfolio.osmosis_address}"
    getBondedLPTokens = HTTParty.get(url).parsed_response
    
    pool = getBondedLPTokens['coins'].select { |pool| pool["denom"] == 'gamm/pool/562' }
    if pool[0].present?
      bondedTokens = pool[0]['amount'].to_f / 1_000_000_000_000_000_000    

      luna_ust_value = bondedTokens * lpTokenValue
      pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: ["terra-luna", "terrausd"])
      pool.current_price = luna_ust_value
      pool.save
    end    
  end
end
