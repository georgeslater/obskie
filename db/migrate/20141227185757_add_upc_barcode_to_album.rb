class AddUpcBarcodeToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :upc_barcode, :string
  end
end
