class RevenueItem < ActiveRecord::Base
	belongs_to :monthlyrevenuereport
	
	validates_presence_of :monthlyrevenuereport
	validates_inclusion_of :fiscal_month, :in => 1..12 #, :message => "can only be between 1 and 12."
	validates_presence_of :item
	validates :value, :format => { :with => /\A[-]?\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 99999999999 }
	
end
