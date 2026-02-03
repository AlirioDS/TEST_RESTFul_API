class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :bio
      t.string :country
      t.integer :formed_year

      t.timestamps
    end
  end
end
