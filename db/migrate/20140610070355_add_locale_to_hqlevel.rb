class AddLocaleToHqlevel < ActiveRecord::Migration
	def self.up
	    
	    change_table(:hqlevels) do |t|
		    t.string :locale
		end
	end

  def self.down
    remove_column :hqlevels, :locale
	
  end
end
