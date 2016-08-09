class AddRankingToBrlevelBrproduct < ActiveRecord::Migration
  def up
    add_column :brlevels, :ranking, :integer, :null => false, :default => 999 #
    add_column :brproducts, :ranking, :integer, :null => false, :default => 999 #
  end

  def down
    remove_column :brlevels, :ranking
    remove_column :brproducts, :ranking
  end
end
