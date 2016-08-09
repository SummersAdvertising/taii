class AddChaosToReplaceMessupInLevel < ActiveRecord::Migration
	def up
    
     add_column :hqlevels, :chaos, :integer , :default => 404
     add_column :brlevels, :chaos, :integer,  :default => 404
     
  end

  def down
  
    remove_column :hqlevels, :chaos
    remove_column :brlevels, :chaos
  
  end

end
