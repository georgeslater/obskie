class AddPlaylistColumnToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :playlist, index: true
  end
end
