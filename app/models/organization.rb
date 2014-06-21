class Organization < ActiveRecord::Base

		translates :org_name, :address
		has_many :representatives ,dependent: :destroy
		
		validates :org_name, :presence => true 
		validates :address, :presence => true 

		def self.with_representatives(orgid)
			Representative.with_translations(I18n.locale).joins(:organization).where(["representatives.organization_id = ?", orgid ])
		end
		
		def self.full_house
  		return Hqlevel.where('parent=0')
    end
    
end
