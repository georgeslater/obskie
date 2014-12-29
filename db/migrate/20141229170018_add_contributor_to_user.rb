class AddContributorToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_approved_contributor, :boolean
  end
end
