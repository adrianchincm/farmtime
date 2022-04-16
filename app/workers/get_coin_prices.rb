require 'sidekiq-scheduler'

class GetCoinPrices
  include Sidekiq::Worker

  def perform
    query = {
      "ids" => "bitcoin,ethereum,fantom,osmosis,terra-luna,cosmos,terrausd,usd-coin,wrapped-steth,ref-finance",
      "vs_currency" => "usd",      
    }

    url =
    'https://api.coingecko.com/api/v3/coins/markets'
    coinPrices = HTTParty.get(url, :query => query).parsed_response      

    coinArray = []

    coinPrices.each { |coin|  
      coin_model = {}
      coin_model["coingecko_id"] = coin["id"]
      coin_model["price"] = coin["current_price"]
      coin_model["price_change_24h"] = coin["price_change_24h"]
      coin_model["name"] = coin["name"]
      coin_model["symbol"] = coin["symbol"].capitalize()
      coinArray << coin_model
    }
    
    Coin.upsert_all(coinArray, unique_by: :coingecko_id)
  end
end