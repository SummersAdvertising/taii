class LetRepresentativeGlobalize < ActiveRecord::Migration
	def self.up 
    	Representative.create_translation_table!({
	    	:division => :string, 
	    	:name => :string, 
	    	:phone => :text, 
	    	:fax => :text, 
	    	:mobile => :text, 
	    	:email => :string
	    }, {
		    :migrate_data => true
		})
		
    	remove_column :representatives, :division
		remove_column :representatives, :name
		remove_column :representatives, :phone
		remove_column :representatives, :fax
		remove_column :representatives, :mobile
		remove_column :representatives, :email
		
	end
	
	def self.down
	
		add_column :representatives, :division, :string
		add_column :representatives, :name, :string
		add_column :representatives, :phone, :text
		add_column :representatives, :fax, :text
		add_column :representatives, :mobile, :text
		add_column :representatives, :email, :string
		
		Representative.drop_translation_table! :migrate_data => true
	end
end
