require "uri"
require "net/http"

class HomeController < ApplicationController
  def index    
    # @luna_ust_value = LunaUstProvider.call() # initial amount : 520 + 560 = 1070
    # @osmo_ust_value = OsmoUstProvider.call() # initial amount : 975
    # @atom_osmo_value = OsmoUstProvider.call() # atom/osmo , initial amount : 575

    @late_quartet_value = LateQuartetProvider.call() # initial amount : 236
    
    @luna_ust_value = 504.23
    @osmo_ust_value = 1023.90
    @atom_osmo_value = 1002.72

    @osmo_price = Coin.find_by(coingecko_id: 'osmosis')["price"]
    @luna_price = Coin.find_by(coingecko_id: 'terra-luna')["price"]
    @atom_price = Coin.find_by(coingecko_id: 'cosmos')["price"]
  end
end
