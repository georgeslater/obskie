class AddBlurbToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :blurb, :text
  end
end
