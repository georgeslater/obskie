class AddRatingsToTracks < ActiveRecord::Migration
  def change
  	add_column :tracks, :author_rating, :float
  end
end
