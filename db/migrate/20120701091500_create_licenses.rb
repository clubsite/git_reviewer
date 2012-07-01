class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :name
      t.string :homepage
      t.string :current_version
      t.string :previous_version
      t.string :license
      t.string :previous_license

      t.timestamps
    end
  end
end
