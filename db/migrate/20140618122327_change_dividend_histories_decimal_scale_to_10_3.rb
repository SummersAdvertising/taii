class ChangeDividendHistoriesDecimalScaleTo103 < ActiveRecord::Migration
  def change
  	  	change_column :dividend_histories, :sre, :decimal, :precision => 10, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :scap, :decimal, :precision => 10, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :cash, :decimal, :precision => 10, :scale => 3, :null => false, :default => 0
		  	change_column :dividend_histories, :total, :decimal, :precision => 10, :scale => 3, :null => false, :default => 0 
  end
end
