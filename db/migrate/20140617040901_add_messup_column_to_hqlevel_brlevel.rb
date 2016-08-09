class AddMessupColumnToHqlevelBrlevel < ActiveRecord::Migration
  def up
    add_column :brlevels, :messup, :boolean, :null => false, :default => false
    add_column :hqlevels, :messup, :boolean, :null => false, :default => false    
  end

  def down
    remove_column :brlevels, :messup
    remove_column :hqlevels, :messup    
  end
end
