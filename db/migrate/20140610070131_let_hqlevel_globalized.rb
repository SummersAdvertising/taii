class LetHqlevelGlobalized < ActiveRecord::Migration
	def self.up 
    	Hqlevel.create_translation_table!({
	    	:name => :string, 
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :hqlevels, :name
		
	end
	
	def self.down
	
		add_column :hqlevels, :name, :string
		
		Hqlevel.drop_translation_table! :migrate_data => true
	end
end
