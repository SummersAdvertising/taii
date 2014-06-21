class Representative < ActiveRecord::Base

		translates :division, :name, :phone, :fax, :mobile, :email
		
		belongs_to :organization
			
		validates :division, :presence => true 
		validates :name, :presence => true 
		validates :phone, :presence => true
		validates :email, :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i}
		
end
