class Brproduct < ActiveRecord::Base
	translates :name
	
	belongs_to :brlevel
	belongs_to :article, :dependent => :destroy
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
	def self.search(search)
	  if search
		  find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	  	  find(:all)
	  end
	end
end
