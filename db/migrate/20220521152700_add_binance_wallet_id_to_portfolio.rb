class AddBinanceWalletIdToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :binance_wallet_id, :integer
  end
end
