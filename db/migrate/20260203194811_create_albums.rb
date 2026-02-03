class CreateAlbums < ActiveRecord::Migration[8.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :genre
      t.integer :total_tracks
      t.integer :duration_seconds
      t.references :release, null: false, foreign_key: true

      t.timestamps
    end
  end
end
