# encoding: utf-8
class Announcement < ActiveRecord::Base
  translates :title
	belongs_to :article, :dependent => :destroy

	default_scope { order('ranking, updated_at DESC') }

	validates_presence_of :title

	paginates_per 5

  after_create {|record| record.update_column(:ranking, 0) }
end
