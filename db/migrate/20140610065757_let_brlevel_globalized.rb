class LetBrlevelGlobalized < ActiveRecord::Migration
	def self.up 
    	Brlevel.create_translation_table!({
	    	:name => :string, 
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :brlevels, :name
		
	end
	
	def self.down
	
		add_column :brlevels, :name, :string
		
		Brlevel.drop_translation_table! :migrate_data => true
	end
end
