require 'sidekiq-scheduler'

class GetCoinPrices
  include Sidekiq::Worker

  def perform
    query = {
        "ids" => "anchor-protocol,osmosis,terra-luna,cosmos",
        "vs_currencies" => "usd",
        "include_24hr_change" => "true"
    }

    url =
    'https://api.coingecko.com/api/v3/simple/price'
  coinPrices = HTTParty.get(url, :query => query).parsed_response  
  end
end