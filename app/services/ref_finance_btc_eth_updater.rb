# frozen_string_literal: true

class RefFinanceBtcEthUpdater < ApplicationService
    def initialize(shares)
      @shares = shares
      @tokens_reward_per_week = 33544
    end  
  
    def call
      url =
        'https://indexer.ref-finance.net/get-pool?pool_id=2734'
      get_btc_eth_pool_response = HTTParty.get(url).parsed_response
  
      total_liquidity = get_btc_eth_pool_response['tvl'].to_f  

      ref_token_price = Coin.find_by(coingecko_id: 'ref-finance').price
  
      rewards_per_day = (@tokens_reward_per_week * ref_token_price) / 7

      apr = ((rewards_per_day / total_liquidity) * 365) * 100 # e.g 23.56
      
      
      
    end
  end
  