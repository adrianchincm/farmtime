# frozen_string_literal: true
require 'openssl'
require 'binance'

class BinanceWalletUpdater < ApplicationService
  WHITELISTED_TOKENS = %w[BETH BTC ETH USDT USDC].freeze
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    client = Binance::Spot.new(key: @portfolio.binance_api_key, secret: @portfolio.binance_secret_key)
    savings = client.savings_flexible_product_position(asset: 'BTC')

    savings[0][:totalAmount]

    snapshot = client.account_snapshot(type: 'SPOT')[:snapshotVos].last    
    
    wallet = Wallet.find(@portfolio.binance_wallet_id)
    wallet.last_updated = Time.at(snapshot[:updateTime]/1000)    
    wallet.total_amount = (snapshot[:data][:totalAssetOfBtc].to_f + BinanceSavingsUpdater.call(@portfolio)) * Coin.find_by(symbol: 'Btc').price
    wallet.save

    filtered_balances = snapshot[:data][:balances].select { |token| WHITELISTED_TOKENS.include?(token[:asset]) }

    filtered_balances.each do |token|
      created_token = Token.find_or_initialize_by(symbol: token[:asset], wallet_id: wallet.id)
      created_token.amount = token[:free].to_f + add_btc_savings(token) 
      created_token.coin_id = Coin.find_by(symbol: token[:asset].titlecase).id
      created_token.save
    end    
  end

  private

  def add_btc_savings(token)    
    return 0 if token[:asset] != "BTC"    
    BinanceSavingsUpdater.call(@portfolio)
  end
end