#encoding: utf-8
class Hqproduct < ActiveRecord::Base
	translates :name
	
	belongs_to :hqlevel  
	belongs_to :article, dependent: :destroy

	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
	validates :organization_id, presence: true
  
	default_scope  { includes(:translations) }  
	
	def self.search(search)
	  if search
		  find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	  	  find(:all)
	  end
	end

end
