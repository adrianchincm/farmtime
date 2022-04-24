class AddFarmtimeIdToPoolStats < ActiveRecord::Migration[7.0]
  def change
    add_column :pool_stats, :farmtime_id, :string
    add_column :pool_stat_dailies, :farmtime_id, :string
  end
end
