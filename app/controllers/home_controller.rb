require "uri"
require "net/http"

class HomeController < ApplicationController
  def index    
    # @luna_ust_value = LunaUstProvider.call()
    # @osmo_ust_value = OsmoUstProvider.call()

    @late_quartet_value = LateQuartetProvider.call()
    
    @luna_ust_value = 504.23
    @osmo_ust_value = 1023.90

    @osmo_price = Coin.find_by(coingecko_id: 'osmosis')["price"]
    @luna_price = Coin.find_by(coingecko_id: 'terra-luna')["price"]
  end
end
