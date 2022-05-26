

class ScriptRunner < ApplicationService  
    WHITELISTED_TOKENS = %w[BETH BTC ETH USDT USDC].freeze
  def initialize; end

  def call
    Wallet.create(wallet_type: "Binance", portfolio_id: Portfolio.second.id, total_amount: 12234.55,last_updated: Time.now())
    

    WHITELISTED_TOKENS.each do |token|
        Token.create(coin_id: Coin.find_by(symbol: token.titlecase).id, wallet_id: Wallet.second.id, amount: 1234.56, symbol: token)
    end  
  end
end