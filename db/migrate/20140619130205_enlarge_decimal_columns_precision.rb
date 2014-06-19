class EnlargeDecimalColumnsPrecision < ActiveRecord::Migration
	def up
  	  	change_column :revenue_items, :value, :decimal, :precision => 17, :scale => 3, :null => false, :default => 0
	  		change_column :dividend_histories, :sre, :decimal, :precision => 17, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :scap, :decimal, :precision => 17, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :cash, :decimal, :precision => 17, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :total, :decimal, :precision => 17, :scale => 3, :null => false, :default => 0 
  end
  
  def down
		  	change_column :revenue_items, :value, :decimal, :null => false, :default => 0
	  		change_column :dividend_histories, :sre, :decimal, :null => false, :default => 0
		  	change_column :dividend_histories, :scap, :decimal, :null => false, :default => 0
		  	change_column :dividend_histories, :cash, :decimal, :null => false, :default => 0
		  	change_column :dividend_histories, :total, :decimal, :null => false, :default => 0
  end
end
