class AddHideAndAccesslevelToBrproduct < ActiveRecord::Migration
	def up
    add_column :brproducts, :accessLevel, :integer, :null => false, :default => 2
    add_column :brproducts, :hide, :bool, :null => false, :default => false
  end

  def down
    remove_column :brproducts, :accessLevel
    remove_column :brproducts, :hide
  end
end
