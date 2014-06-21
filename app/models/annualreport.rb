class Annualreport < ActiveRecord::Base
	
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
	
  validates :fiscal_year, :inclusion => 1..200
	validates_uniqueness_of :fiscal_year
	
	
end
