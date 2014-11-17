class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :track, index: true
      t.float :score
      t.string :ip_address

      t.timestamps
    end
  end
end
