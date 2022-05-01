class AddVaultProviderToPoolStats < ActiveRecord::Migration[7.0]
  def change
    add_column :pool_stats, :vault_provider, :string
  end
end
