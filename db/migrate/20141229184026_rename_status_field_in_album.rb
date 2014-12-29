class RenameStatusFieldInAlbum < ActiveRecord::Migration
  def change
  	rename_column :albums, :workflow_status, :workflow_state
  end
end
