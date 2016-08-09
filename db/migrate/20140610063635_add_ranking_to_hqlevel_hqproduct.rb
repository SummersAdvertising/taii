class AddRankingToHqlevelHqproduct < ActiveRecord::Migration
	def up
    add_column :hqlevels, :ranking, :integer, :null => false, :default => 999 #
    add_column :hqproducts, :ranking, :integer, :null => false, :default => 999 #
  end

  def down
    remove_column :hqlevels, :ranking
    remove_column :hqproducts, :ranking
  end
end
