class AddShowFrontColumnToBrproduct < ActiveRecord::Migration
	def up
    add_column :brproducts, :showfront, :integer, :default => 0
  end

  def down
    remove_column :brproducts, :showfront    
  end
end
