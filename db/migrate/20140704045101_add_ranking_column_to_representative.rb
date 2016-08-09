class AddRankingColumnToRepresentative < ActiveRecord::Migration
  def up
    add_column :representatives, :ranking, :integer, :null => false, :default => 999 #
  end

  def down
    remove_column :representatives, :ranking
  end
end
