class AddLastSyncedAtToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :last_synced_at, :datetime
  end
end
