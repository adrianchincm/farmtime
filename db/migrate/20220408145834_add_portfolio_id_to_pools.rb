class AddPortfolioIdToPools < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :portfolio_id, :integer
  end
end
