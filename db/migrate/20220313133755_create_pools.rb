class CreatePools < ActiveRecord::Migration[7.0]
  def change
    create_table :pools do |t|
      t.string :tokens, array: true, default: []
      t.string :name
      t.string :pool_owner
      t.float :current_price
      t.float :initial_capital

      t.timestamps
    end
  end
end
