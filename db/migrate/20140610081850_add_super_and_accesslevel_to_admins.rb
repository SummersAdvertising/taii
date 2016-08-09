class AddSuperAndAccesslevelToAdmins < ActiveRecord::Migration
def self.up
    add_column :admins, :super, :boolean, :default => false
    add_column :admins, :accessLevel, :integer, :default => 2
  end

  def self.down
    remove_column :admins, :super
    remove_column :admins, :accessLevel
  end
end
