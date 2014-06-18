class LetHqproductGlobalized < ActiveRecord::Migration
	def self.up 
    	Hqproduct.create_translation_table!({
	    	:name => :string, 
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :hqproducts, :name
		
	end
	
	def self.down
	
		add_column :hqproducts, :name, :string
		
		Hqproduct.drop_translation_table! :migrate_data => true
	end
end
