require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    # @ancUstValue = AncUstProvider.call()
    # @lunaUstValue = LunaUstProvider.call()
    # @osmoUstValue = OsmoUstProvider.call()

    @lateQuartetValue = LateQuartetProvider.call()

    @ancUstValue = 1234.23
    @lunaUstValue = 504.23
    @osmoUstValue = 1023.90

    query = {
      "ids" => "anchor-protocol,osmosis,terra-luna,cosmos",
      "vs_currencies" => "usd",
      "include_24hr_change" => "true"
  }

  url =
  'https://api.coingecko.com/api/v3/simple/price'
  coinPrices = HTTParty.get(url, :query => query).parsed_response  
  p coinPrices
  p coinPrices.keys

  coinArray = []
  coinPrices.keys.each { |key|
    coinPrices[key]["coingecko_id"] = key
    coinPrices[key]["price"] = coinPrices[key]["usd"]
    coinPrices[key]["price_change_24h"] = coinPrices[key]["usd_24h_change"]
    coinArray << coinPrices[key].except("usd", "usd_24h_change")
  }

  # p coinArray
  
  Coin.upsert_all(coinArray, unique_by: :coingecko_id)
  end
end
