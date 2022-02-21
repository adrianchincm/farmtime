require 'sidekiq-scheduler'

class GetCoinPrices
  include Sidekiq::Worker

  def perform
    query = {
      "ids" => "bitcoin,ethereum,fantom,osmosis,terra-luna,cosmos",
      "vs_currencies" => "usd",
      "include_24hr_change" => "true"
    }

    url =
    'https://api.coingecko.com/api/v3/simple/price'
    coinPrices = HTTParty.get(url, :query => query).parsed_response      

    coinArray = []
    coinPrices.keys.each { |key|
      coinPrices[key]["coingecko_id"] = key
      coinPrices[key]["price"] = coinPrices[key]["usd"]
      coinPrices[key]["price_change_24h"] = coinPrices[key]["usd_24h_change"]
      coinArray << coinPrices[key].except("usd", "usd_24h_change")
    }    
    
    Coin.upsert_all(coinArray, unique_by: :coingecko_id)
  end
end