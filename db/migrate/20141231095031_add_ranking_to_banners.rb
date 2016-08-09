class AddRankingToBanners < ActiveRecord::Migration
  def up
    add_column :banners, :ranking, :integer, :null => false, :default => 999 #
  end

  def down
    remove_column :banners, :ranking
  end
end
