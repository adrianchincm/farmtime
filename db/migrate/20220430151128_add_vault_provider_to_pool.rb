class AddVaultProviderToPool < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :vault_provider, :string
  end
end
