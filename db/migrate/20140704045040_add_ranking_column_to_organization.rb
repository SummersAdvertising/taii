class AddRankingColumnToOrganization < ActiveRecord::Migration
  def up
    add_column :organizations, :ranking, :integer, :null => false, :default => 999
  end

  def down
    remove_column :organizations, :ranking
  end 
end
