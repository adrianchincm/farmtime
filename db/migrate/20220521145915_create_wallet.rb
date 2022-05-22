class CreateWallet < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :wallet_type
      t.integer :portfolio_id
      t.float :total_amount
      t.datetime :last_updated

      t.timestamps
    end
  end
end
