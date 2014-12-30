class RemoveApprovedFromAlbum < ActiveRecord::Migration
  def change
  		remove_column :albums, :approved
  end
end
