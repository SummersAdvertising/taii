class AddOrgIdToBrproduct < ActiveRecord::Migration
  def up
    add_column :brproducts, :organization_id, :integer, :null => false, :default => 0
  end

  def down
    remove_column :brproducts, :organization_id
  end
end
