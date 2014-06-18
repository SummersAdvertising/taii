class Monthlyrevenuereport < ActiveRecord::Base

	has_many :revenue_items, -> { order('ranking, created_at') }, dependent: :destroy
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
	
end
