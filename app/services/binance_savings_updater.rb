# frozen_string_literal: true
require 'binance'

class BinanceSavingsUpdater < ApplicationService  
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    client = Binance::Spot.new(key: @portfolio.binance_api_key, secret: @portfolio.binance_secret_key)
    savings = client.savings_flexible_product_position(asset: 'BTC')
    puts savings.to_json

    return 0 if savings.empty?

    savings[0][:totalAmount].to_f
  end
end