class CreateRevenueItems < ActiveRecord::Migration
  def change
    create_table :revenue_items do |t|
      t.integer :fiscal_month , :null => false
      t.string :item , :null => false
      t.decimal :value, :null => false, :default => 0, :precision => 3, :scale => 3
      t.integer :ranking, :default => 999
		  t.references :monthlyrevenuereport, index: true

      t.timestamps
    end
  end
end
