class CreatePoolStatDailies < ActiveRecord::Migration[7.0]
  def change
    create_table :pool_stat_dailies do |t|
      t.string :name
      t.float :tvl
      t.float :apy      
      t.string :coindix_id

      t.timestamps
    end
  end
end
