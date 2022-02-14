# frozen_string_literal: true

class AncUstProvider < ApplicationService
  def initialize; end

  def call
    url =
      'https://fcd.terra.dev/v1/bank/terra1qr2k6yjjd5p2kaewqvg93ag74k6gyjr7re37fs'
    getUST = HTTParty.get(url).parsed_response

    url =
      'https://mantle.terra.dev/'
    getANC = HTTParty.post(url, body: "{ \"query\": \"{\\n  terra14z56l0fp2lsf86zy3hty2z47ezkhnthtr9yq76: WasmContractsContractAddressStore(\\n    ContractAddress: \\\"terra14z56l0fp2lsf86zy3hty2z47ezkhnthtr9yq76\\\"\\n    QueryMsg: \\\"{\\\\\\\"balance\\\\\\\":{\\\\\\\"address\\\\\\\":\\\\\\\"terra1qr2k6yjjd5p2kaewqvg93ag74k6gyjr7re37fs\\\\\\\"}}\\\"\\n  ) {\\n    Height\\n    Result\\n    __typename\\n  }\\n}\\n\" }",
                                headers: { 'Content-Type' => 'text/plain' }).parsed_response
                                
    ancBalanceString = ActiveSupport::JSON.decode(getANC['data']['terra14z56l0fp2lsf86zy3hty2z47ezkhnthtr9yq76']['Result'])
    ancBalance = ancBalanceString['balance'].to_f / 1_000_000

    url =
      'https://api.coingecko.com/api/v3/coins/anchor-protocol?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false'
    ancCoinDetails = HTTParty.get(url).parsed_response

    totalAncUstLiquidity = (ancBalance * ancCoinDetails['market_data']['current_price']['usd']) + (getUST['balance'][0]['available'].to_f / 1_000_000)

    url =
      'https://fcd.terra.dev/wasm/contracts/terra1wmaty65yt7mjw6fjfymkd9zsm6atsq82d9arcd/store?query_msg={%22token_info%22:{}}'
    lpTokens = HTTParty.get(url).parsed_response

    totalLPTokens = lpTokens['result']['total_supply'].to_f / 1_000_000

    lpTokenValue = totalAncUstLiquidity / totalLPTokens

    url =
      'https://lcd.terra.dev/wasm/contracts/terra1ukm33qyqx0qcz7rupv085rgpx0tp5wzkhmcj3f/store?query_msg=%7B%22reward_info%22:%7B%22staker_addr%22:%22terra1n5rkxxys26v0ks0yptp0a7v9wt5v3q85g4s4hq%22%7D%7D'
    specLPTokens = HTTParty.get(url).parsed_response

    totalSpecLPTokens = specLPTokens['result']['reward_infos'][0]['bond_amount'].to_f / 1_000_000

    totalSpecLPTokens * lpTokenValue
  end
end
