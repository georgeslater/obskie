class AddSlugToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :slug, :string
    add_index :playlists, :slug
  end
end
