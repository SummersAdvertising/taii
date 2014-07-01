# encoding: utf-8
class Announcement < ActiveRecord::Base
	belongs_to :article, :dependent => :destroy

	default_scope { order('ranking, created_at DESC') }
	
	validates_presence_of :title
	
	paginates_per 5
	
end
