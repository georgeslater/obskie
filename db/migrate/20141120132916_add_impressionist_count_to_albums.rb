class AddImpressionistCountToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :impressionist_count, :integer
  end
end
