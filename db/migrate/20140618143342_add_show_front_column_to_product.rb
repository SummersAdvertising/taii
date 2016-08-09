class AddShowFrontColumnToProduct < ActiveRecord::Migration
	def up
    add_column :hqproducts, :showfront, :integer, :default => 0
  end

  def down
    remove_column :hqproducts, :showfront    
  end
end
