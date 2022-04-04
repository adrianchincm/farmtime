class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    enable_extension "hstore"
    create_table :portfolios do |t|
      t.integer :user_id # might add user functionality in the future
      t.string :terra_address
      t.string :fantom_address
      t.string :osmosis_address
      t.text :ref_finance_shares

      t.timestamps
    end
  end
end
