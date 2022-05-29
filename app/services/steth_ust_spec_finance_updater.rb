# frozen_string_literal: true

class StethUstSpecFinanceUpdater < ApplicationService
    def initialize(portfolio)
        @portfolio = portfolio
    end
  
    def call
      pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: ["wrapped-steth", "terrausd"])
      if !pool.vault_provider.nil? && pool.vault_provider == "spectrum_finance"
            url =
            'https://fcd.terra.dev/wasm/contracts/terra1edurrzv6hhd8u48engmydwhvz8qzmhhuakhwj3/store?query_msg={%22pool%22:{}}'
        get_pool_response = HTTParty.get(url).parsed_response
    
        steth_in_usd = (get_pool_response["result"]["assets"][0]["amount"].to_f / 100000000) * Coin.find_by(coingecko_id: 'wrapped-steth').price
        ust = get_pool_response["result"]["assets"][1]["amount"].to_f / 1000000
    
        pool_tvl = steth_in_usd + ust
    
        total_lp_tokens = get_pool_response["result"]["total_share"].to_f / 1000000  
            
        # get Total LP Tokens
        url =
            'https://hive.terra.dev/graphql'
        get_user_lp_tokens = HTTParty.post(url, body: "{\"query\":\"{stakedterra1qz4cv5lsfw4k2266q52z9rtz64n58paxy9d476: wasm {\\n            contractQuery(\\n              contractAddress: \\\"terra1zgrx9jjqrfye8swykfgmd6hpde60j0nszzupp9\\\"\\n              query: {\\n                deposit: {\\n                  lp_token: \\\"terra1qz4cv5lsfw4k2266q52z9rtz64n58paxy9d476\\\"\\n                  user: \\\"#{@portfolio.terra_address}\\\"\\n                }\\n              }\\n            )\\n          }\\n}\",\"variables\":{}}",
        headers: { 'Content-Type' => 'application/json' }).parsed_response

        url =
        "https://lcd.terra.dev/wasm/contracts/terra12td8as6zhm3m9djjmpxzfue9syvrj0ewe070hf/store?query_msg=%7B%22reward_info%22:%7B%22staker_addr%22:%22#{@portfolio.terra_address}%22%7D%7D"
        get_spec_staked_lp_tokens = HTTParty.get(url).parsed_response

        puts get_spec_staked_lp_tokens

        if get_spec_staked_lp_tokens["result"]["reward_infos"].present?
          user_lp_tokens = get_spec_staked_lp_tokens["result"]["reward_infos"][0]["auto_bond_amount"].to_f / 1000000
            
          # get staked pool value
          value_per_lp_token = pool_tvl / total_lp_tokens
          
          steth_ust_pool_value = user_lp_tokens * value_per_lp_token          
                  
          pool.current_price = steth_ust_pool_value
          pool.save 
        end

       
      end
      # get Pool TVL
          
    end
  end
    