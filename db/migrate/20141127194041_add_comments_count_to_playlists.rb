class AddCommentsCountToPlaylists < ActiveRecord::Migration
  def change
  	add_column :playlists, :comments_count, :integer, :default => 0
  end
end
