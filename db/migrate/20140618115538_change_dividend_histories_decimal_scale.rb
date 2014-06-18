class ChangeDividendHistoriesDecimalScale < ActiveRecord::Migration
  def change
  	change_column :dividend_histories, :sre, :decimal, :precision => 3, :scale => 3, :null => false, :default => 0
  	change_column :dividend_histories, :scap, :decimal, :precision => 3, :scale => 3, :null => false, :default => 0
  	change_column :dividend_histories, :cash, :decimal, :precision => 3, :scale => 3, :null => false, :default => 0
  	change_column :dividend_histories, :total, :decimal, :precision => 3, :scale => 3, :null => false, :default => 0 
  end
end
