class AddAccesslevelToOrganizations < ActiveRecord::Migration
	def up
    
     add_column :organizations, :accessLevel, :integer , :default => 2
     
  end

  def down
  
	   remove_column :organizations, :accessLevel
  
  end
end
