class ChangeRevenueItemsPrecision < ActiveRecord::Migration
	def up
  	  	change_column :revenue_items, :value, :decimal, :precision => 10, :scale => 3, :null => false, :default => 0
  end
  
  def down
		  	change_column :revenue_items, :value, :decimal, :null => false, :default => 0
  end
end
