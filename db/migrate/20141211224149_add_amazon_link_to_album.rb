class AddAmazonLinkToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :amazon_url, :string
  end
end
