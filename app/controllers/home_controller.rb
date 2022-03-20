require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @pools = Pool.all.sort_by(&:pool_owner)
    
    @luna_ust_pool = Pool.find_by(name: "LUNA-UST")
    @luna_ust_value = Pool.find_by(name: "LUNA-UST").current_price # initial amount : 520 + 560 = 1070
    @osmo_ust_value = Pool.find_by(name: "OSMO-UST").current_price # initial amount : 975
    @atom_osmo_value = Pool.find_by(name: "ATOM-OSMO").current_price # atom/osmo , initial amount : 575

    @late_quartet_value = Pool.find_by(name: "Late Quartet").current_price # initial amount : 236
    
    # @luna_ust_value = 504.23
    # @osmo_ust_value = 1023.90
    # @atom_osmo_value = 1002.72

    @osmo_price = Coin.find_by(coingecko_id: 'osmosis')["price"]
    @luna_price = Coin.find_by(coingecko_id: 'terra-luna')["price"]
    @atom_price = Coin.find_by(coingecko_id: 'cosmos')["price"]

    @btc_price = Coin.find_by(coingecko_id: 'bitcoin')["price"]
    @eth_price = Coin.find_by(coingecko_id: 'ethereum')["price"]
    @ftm_price = Coin.find_by(coingecko_id: 'fantom')["price"]
  end
end
