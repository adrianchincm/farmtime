class AddNameToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :name, :string
  end
end
