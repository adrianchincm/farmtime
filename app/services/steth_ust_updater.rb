# frozen_string_literal: true

class StethUstUpdater < ApplicationService
    def initialize; end
  
    def call
      # get Pool TVL
      url =
        'https://fcd.terra.dev/wasm/contracts/terra1edurrzv6hhd8u48engmydwhvz8qzmhhuakhwj3/store?query_msg={%22pool%22:{}}'
      get_pool_response = HTTParty.get(url).parsed_response
  
      steth_in_usd = (get_pool_response["result"]["assets"][0]["amount"].to_f / 100000000) * Coin.find_by(coingecko_id: 'ethereum').price
      ust = get_pool_response["result"]["assets"][1]["amount"].to_f / 1000000

      pool_tvl = steth_in_usd + ust

      total_lp_tokens = get_pool_response["result"]["total_share"].to_f / 1000000  
        
      # get Total LP Tokens
      url =
        'https://hive.terra.dev/graphql'
      get_user_lp_tokens = HTTParty.post(url, body: "{\"query\":\"{stakedterra1qz4cv5lsfw4k2266q52z9rtz64n58paxy9d476: wasm {\\n            contractQuery(\\n              contractAddress: \\\"terra1zgrx9jjqrfye8swykfgmd6hpde60j0nszzupp9\\\"\\n              query: {\\n                deposit: {\\n                  lp_token: \\\"terra1qz4cv5lsfw4k2266q52z9rtz64n58paxy9d476\\\"\\n                  user: \\\"terra1n5rkxxys26v0ks0yptp0a7v9wt5v3q85g4s4hq\\\"\\n                }\\n              }\\n            )\\n          }\\n}\",\"variables\":{}}",
      headers: { 'Content-Type' => 'application/json' }).parsed_response

      user_lp_tokens = get_user_lp_tokens["data"]["stakedterra1qz4cv5lsfw4k2266q52z9rtz64n58paxy9d476"]["contractQuery"].to_f / 1000000        
        
      # get staked pool value
      value_per_lp_token = pool_tvl / total_lp_tokens
      puts "TOTAL LP TOKENS : #{total_lp_tokens}"
      puts "POOL TVL : #{pool_tvl}"
      puts "VALUE PER LP TOKEN : #{value_per_lp_token}"
      steth_ust_pool_value = user_lp_tokens * value_per_lp_token      
      puts "POOL VALUE : #{steth_ust_pool_value}"
      
      pool = Pool.find_by(tokens: ["wrapped-steth", "terrausd"])
      pool.current_price = steth_ust_pool_value
      pool.save     
    end
  end
  