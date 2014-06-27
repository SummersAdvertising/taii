class DividendHistory < ActiveRecord::Base

	default_scope { order('ranking, created_at') }
	
  validates :fiscal_year, :inclusion => 1..200
	validates_uniqueness_of :fiscal_year	
	
	validates :sre, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :scap, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :cash, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :total, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	
# 	validate :happened_at_is_valid_datetime
# 
#   def happened_at_is_valid_datetime
#     errors.add(:happened_at, 'must be a valid datetime') if ((DateTime.parse(happened_at) rescue ArgumentError) == ArgumentError)
#   end
#   
#   record.errors[attribute] << I18n.t('model.errors.custom.arrival_date') if record.departure_date > record.arrival_date

end
