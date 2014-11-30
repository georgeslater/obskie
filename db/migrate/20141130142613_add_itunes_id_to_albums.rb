class AddItunesIdToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :itunes_identifier, :string
  end
end
