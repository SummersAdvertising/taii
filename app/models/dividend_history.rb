class DividendHistory < ActiveRecord::Base
	default_scope { order('ranking, created_at') }
	validates :sre, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :scap, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :cash, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
	validates :total, :format => { :with => /\A\d+(?:\.\d{0,3})?\z/ }, :numericality => { :less_than => 9999 }
end
