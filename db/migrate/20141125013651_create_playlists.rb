class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|

      t.string :spotify_uri
      t.string :name
      t.references :user
      t.timestamps
    end
  end
end
