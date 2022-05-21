class AddBinanceApiToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :binance_api_key, :string
    add_column :portfolios, :binance_secret_key, :string
  end
end
