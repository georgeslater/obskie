class AddAmazonUrlCaToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :amazon_url_ca, :string
  end
end
