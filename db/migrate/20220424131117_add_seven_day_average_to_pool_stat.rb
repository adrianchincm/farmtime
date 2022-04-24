class AddSevenDayAverageToPoolStat < ActiveRecord::Migration[7.0]
  def change
    add_column :pool_stats, :apy_7d_average, :float
    add_column :pool_stats, :tvl_7d_average, :float
  end
end
