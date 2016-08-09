#encoding: utf-8
class Hqproduct < ActiveRecord::Base
	translates :name
	
	belongs_to :hqlevel  
	belongs_to :article, dependent: :destroy

	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
	validates :organization_id, presence: true
  
	default_scope  { includes(:translations) }  
	
	# def self.search(search)
	#   if search
	#     Hqproduct.with_translations(I18n.locale).where(['name LIKE ? and showatfront = 200 ', "%#{search}%"])
	# 	  #find(:all, :conditions => ['name LIKE ? and showatfront = 200 ', "%#{search}%"])
	#   else
	# 	  Hqproduct.with_translations(I18n.locale).where(['showatfront = 200 '])
	#   	#find(:all, :conditions => ['showatfront = 200 ', "%#{search}%"])
	#   end
	# end

end
