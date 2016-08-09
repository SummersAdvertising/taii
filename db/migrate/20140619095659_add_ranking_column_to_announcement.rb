class AddRankingColumnToAnnouncement < ActiveRecord::Migration
	def up
    add_column :announcements, :ranking, :integer, :null => false, :default => 999 #
  end

  def down
    remove_column :announcements, :ranking
  end
end
