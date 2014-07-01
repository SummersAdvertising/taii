#encoding: utf-8
class Brproduct < ActiveRecord::Base
	translates :name
	
	belongs_to :brlevel
	belongs_to :article, :dependent => :destroy
	
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
	def self.search(search)
	  if search
		  Brproduct.with_translations(I18n.locale).where(['name LIKE ? and showatfront = 200 ', "%#{search}%"])
		  #find(:all, :conditions => ['name LIKE ? and showatfront = 200 ', "%#{search}%" ])
	  else
		  Brproduct.with_translations(I18n.locale).where(['showatfront = 200 '])
	  	#find(:all)
	  end
	end
end
