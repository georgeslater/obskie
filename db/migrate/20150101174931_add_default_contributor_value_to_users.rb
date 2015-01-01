class AddDefaultContributorValueToUsers < ActiveRecord::Migration
  def change
  	    change_column :users, :is_approved_contributor, :boolean, :default => false
  end
end
