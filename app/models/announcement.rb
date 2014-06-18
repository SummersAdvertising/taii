# encoding: utf-8
class Announcement < ActiveRecord::Base
	belongs_to :article, :dependent => :destroy
	validates_presence_of :title
end
