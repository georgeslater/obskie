class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :album, index: true

      t.timestamps
    end
  end
end
