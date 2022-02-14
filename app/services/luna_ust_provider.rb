# frozen_string_literal: true

class LunaUstProvider < ApplicationService
  def initialize; end

  def call
    url =
      'https://api-osmosis.imperator.co/pools/v1/562'
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
      'https://lcd-osmosis.keplr.app/osmosis/lockup/v1beta1/account_locked_coins/osmo10l6e5ch3px3vavqgx5qmee82v0jhwl6wu6tt33'
    getBondedLPTokens = HTTParty.get(url).parsed_response

    bondedTokens = getBondedLPTokens['coins'][1]['amount'].to_f / 1_000_000_000_000_000_000

    bondedTokens * lpTokenValue
  end
end
