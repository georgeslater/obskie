class AddImpressionsCountToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :impressions_count, :integer
  end
end
