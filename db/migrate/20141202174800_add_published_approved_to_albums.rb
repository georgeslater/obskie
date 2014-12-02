class AddPublishedApprovedToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :published, :boolean, null: false, default: false
    add_column :albums, :approved, :boolean, null: false, default: false
  end
end
