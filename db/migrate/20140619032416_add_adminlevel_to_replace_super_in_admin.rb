class AddAdminlevelToReplaceSuperInAdmin < ActiveRecord::Migration
	def up
    
     add_column :admins, :superadmin, :integer , :default => 0
     
  end

  def down
  
	   remove_column :admins, :superadmin, :integer , :default => 1
  
  end
end
