class AddOrgIdToHqproducts < ActiveRecord::Migration
  def up
    add_column :hqproducts, :organization_id, :integer, :null => false, :default => 0
  end

  def down
    remove_column :hqproducts, :organization_id
  end
end
