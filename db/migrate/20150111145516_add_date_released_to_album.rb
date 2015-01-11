class AddDateReleasedToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :date_released, :date
  end
end
