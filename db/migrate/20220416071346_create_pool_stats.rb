class CreatePoolStats < ActiveRecord::Migration[7.0]
  def change
    create_table :pool_stats do |t|
      t.string :tokens, array: true, default: []
      t.string :pool_owner
      t.float :tvl
      t.float :apr
      t.string :coindix_id

      t.timestamps
    end
  end
end
