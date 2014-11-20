class RemoveImpressionsCountFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :impressions_count, :integer
  end
end
