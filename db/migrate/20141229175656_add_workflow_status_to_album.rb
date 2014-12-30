class AddWorkflowStatusToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :workflow_status, :string
  end
end
