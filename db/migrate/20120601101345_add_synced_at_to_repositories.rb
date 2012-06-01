class AddSyncedAtToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :synced_at, :datetime
  end
end
