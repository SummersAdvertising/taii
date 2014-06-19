# encoding: utf-8
class Announcement < ActiveRecord::Base
	belongs_to :article, :dependent => :destroy

	default_scope order('ranking, created_at DESC') 
	
	validates_presence_of :title
	
	
end
