class CreateArtistReleases < ActiveRecord::Migration[8.0]
  def change
    create_table :artist_releases do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :release, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
