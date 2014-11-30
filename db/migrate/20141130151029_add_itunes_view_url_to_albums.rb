class AddItunesViewUrlToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :itunes_view_url, :string
  end
end
