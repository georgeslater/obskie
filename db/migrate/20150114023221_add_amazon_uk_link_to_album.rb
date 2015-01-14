class AddAmazonUkLinkToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :amazon_url_uk, :string
  end
end
