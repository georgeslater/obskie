class ChangeDefaultApproved < ActiveRecord::Migration
  def change
  	change_column_default(:albums, :approved, true)
  end
end
