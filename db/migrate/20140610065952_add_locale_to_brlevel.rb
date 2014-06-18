class AddLocaleToBrlevel < ActiveRecord::Migration
	def self.up
	    
	    change_table(:brlevels) do |t|
		    t.string :locale
		end
	end

  def self.down
    remove_column :brlevels, :locale
	
  end
end
