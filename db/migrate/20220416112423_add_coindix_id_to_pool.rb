class AddCoindixIdToPool < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :pool_stat_id, :integer
  end
end
