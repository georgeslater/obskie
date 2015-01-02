class AddWorkflowStateIndexToAlbums < ActiveRecord::Migration
  def change
  	add_index :albums, :workflow_state
  end
end
