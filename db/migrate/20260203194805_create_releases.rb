class CreateReleases < ActiveRecord::Migration[8.0]
  def change
    create_table :releases do |t|
      t.string :title
      t.date :release_date
      t.string :release_type
      t.string :label
      t.string :catalog_number

      t.timestamps
    end
  end
end
