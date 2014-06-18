class Financialreport < ActiveRecord::Base
	
	validates_uniqueness_of :fiscal_year
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
	
end
