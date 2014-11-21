class RemoveCountFromAlbums < ActiveRecord::Migration
  def change
  	remove_column :albums, :impressionist_count
  end
end
