# frozen_string_literal: true

class BtcEthUpdater < ApplicationService
  def initialize; end

  BTC_ETH_SHARES = 0.059490

  def call
    url =
      'https://indexer.ref-finance.net/get-pool?pool_id=2734'
    get_btc_eth_pool_response = HTTParty.get(url).parsed_response

    total_liquidity = get_btc_eth_pool_response['tvl'].to_f  

    shares_total_supply = get_btc_eth_pool_response['shares_total_supply'].to_f / 1_000_000_000_000_000_000_000_000

    lp_token_value = total_liquidity / shares_total_supply

    pool_value = BTC_ETH_SHARES * lp_token_value
    pool = Pool.find_by(tokens: %w[bitcoin ethereum])
    pool.current_price = pool_value    
    pool.save
  end
end