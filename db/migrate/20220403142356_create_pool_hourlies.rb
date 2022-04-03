class CreatePoolHourlies < ActiveRecord::Migration[7.0]
  def change
    create_table :pool_hourlies do |t|
      t.integer :pool_id
      t.string :tokens, array: true, default: []
      t.string :name
      t.string :pool_owner
      t.float :current_price            

      t.timestamps
    end
  end
end
