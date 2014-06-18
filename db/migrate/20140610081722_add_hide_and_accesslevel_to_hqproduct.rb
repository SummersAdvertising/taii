class AddHideAndAccesslevelToHqproduct < ActiveRecord::Migration
	def up
    add_column :hqproducts, :accessLevel, :integer, :null => false, :default => 2
    add_column :hqproducts, :hide, :bool, :null => false, :default => false
  end

  def down
    remove_column :hqproducts, :accessLevel
    remove_column :hqproducts, :hide
  end
end
