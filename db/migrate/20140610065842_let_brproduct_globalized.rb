class LetBrproductGlobalized < ActiveRecord::Migration
	def self.up 
    	Brproduct.create_translation_table!({
	    	:name => :string, 
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :brproducts, :name
		
	end
	
	def self.down
	
		add_column :brproducts, :name, :string
		
		Brproduct.drop_translation_table! :migrate_data => true
	end
end
