class RemoveImpressionistCountFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :impressionist_count, :integer
  end
end
