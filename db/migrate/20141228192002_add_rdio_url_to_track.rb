class AddRdioUrlToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :rdio_url, :string
  end
end
