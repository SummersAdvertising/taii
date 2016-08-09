class Financialprojection < ActiveRecord::Base
	belongs_to :article, :dependent => :destroy
	has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
end
