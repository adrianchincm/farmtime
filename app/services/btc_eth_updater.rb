# frozen_string_literal: true

class BtcEthUpdater < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    url =
      'https://indexer.ref-finance.net/get-pool?pool_id=2734'
    get_btc_eth_pool_response = HTTParty.get(url).parsed_response

    total_liquidity = get_btc_eth_pool_response['tvl'].to_f  

    shares_total_supply = get_btc_eth_pool_response['shares_total_supply'].to_f / 1_000_000_000_000_000_000_000_000

    lp_token_value = total_liquidity / shares_total_supply
    
    pool_value = @portfolio.ref_finance_shares["btceth"].to_f * lp_token_value        
    pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: %w[bitcoin ethereum])
    pool.current_price = pool_value
    pool.save
  end
end
