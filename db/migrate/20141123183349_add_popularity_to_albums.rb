class AddPopularityToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :obscurity_rating, :integer
  end
end
