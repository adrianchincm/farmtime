class CreatePoolDailies < ActiveRecord::Migration[7.0]
  def change
    create_table :pool_dailies do |t|
      t.integer :pool_id
      t.integer :portfolio_id
      t.float :current_price

      t.timestamps
    end
  end
end
