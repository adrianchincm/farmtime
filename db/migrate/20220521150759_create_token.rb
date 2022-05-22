class CreateToken < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.integer :coin_id
      t.integer :wallet_id
      t.float :amount
      t.string :symbol

      t.timestamps
    end
  end
end
