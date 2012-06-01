class AddStatusToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :reviewer_id, :integer
    add_column :commits, :status, :string, default: "open"

    add_index :commits, [:repository_id, :status]
    add_index :commits, [:repository_id, :reviewer_id]
  end
end
