class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins do |t|
      t.string :coingecko_id, index: { unique: true }
      t.string :symbol
      t.string :name
      t.float :price
      t.float :price_change_24h

      t.timestamps
    end
  end
end
