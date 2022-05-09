class AddActiveToPools < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :is_active, :boolean
  end
end
