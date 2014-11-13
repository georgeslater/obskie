class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :album_art
      t.integer :year
      t.text :body
      t.string :spotify_identifier

      t.timestamps
    end
  end
end
