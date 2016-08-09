class ChangeShowFrontColumnDefaultValueToProduct < ActiveRecord::Migration
	def up
    
     add_column :hqproducts, :showatfront, :integer , :default => 404
     add_column :brproducts, :showatfront, :integer,  :default => 404
     
  end

  def down
  
    remove_column :hqproducts, :showatfront
    remove_column :brproducts, :showatfront
  
  end
end
