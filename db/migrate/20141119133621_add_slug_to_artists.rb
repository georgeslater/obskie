class AddSlugToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string, :unique => true
  end
end
