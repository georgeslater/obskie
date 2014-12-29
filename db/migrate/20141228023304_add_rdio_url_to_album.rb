class AddRdioUrlToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :rdio_url, :string
  end
end
