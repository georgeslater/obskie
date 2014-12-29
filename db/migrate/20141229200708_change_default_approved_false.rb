class ChangeDefaultApprovedFalse < ActiveRecord::Migration
  def change
  	  	change_column_default(:albums, :approved, false)
  end
end
