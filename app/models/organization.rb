class Organization < ActiveRecord::Base

		translates :org_name, :address
		has_many :representatives ,dependent: :destroy
		
		validates :org_name, :presence => true 
		validates :address, :presence => true 

end
