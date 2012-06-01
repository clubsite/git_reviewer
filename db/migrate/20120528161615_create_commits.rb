class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha
      t.references :repository
      t.string :author_name
      t.string :author_email
      t.datetime :written_at
      t.string :committer_name
      t.string :committer_email
      t.datetime :committed_at
      t.text :message

      t.timestamps
    end
    add_index :commits, [:repository_id, :sha]
  end
end
