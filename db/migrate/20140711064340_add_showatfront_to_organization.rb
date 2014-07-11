class AddShowatfrontToOrganization < ActiveRecord::Migration
  def up
    add_column :organizations, :showatfront, :integer, :default => 404
  end

  def down
    remove_column :organizations, :showatfront
  end 
end
