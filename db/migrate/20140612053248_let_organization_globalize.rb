class LetOrganizationGlobalize < ActiveRecord::Migration
	def self.up 
    	Organization.create_translation_table!({
	    	:org_name => :string, 
	    	:address => :text
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :organizations, :org_name
		remove_column :organizations, :address
		
	end
	
	def self.down
	
		add_column :organizations, :org_name, :string
		add_column :organizations, :address, :text
		
		Organization.drop_translation_table! :migrate_data => true
	end
end
