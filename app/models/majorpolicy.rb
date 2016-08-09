class Majorpolicy < ActiveRecord::Base
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
end
