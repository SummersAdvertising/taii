# encoding: utf-8
class Banner < ActiveRecord::Base

  translates :url_1, :url_2, :url_3
  has_many :attachments, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  validates_presence_of :url_1, :url_2, :url_3, on: :update
  
  default_scope { order('ranking, created_at') }

  before_create :check_before_create
  before_update :check_before_update

  private 

  def check_before_create
    self.url_1 = 'http://tw.yahoo.com' if self.url_1.blank?
    self.url_2 = 'http://tw.yahoo.com' if self.url_2.blank?
    self.url_3 = 'http://tw.yahoo.com' if self.url_3.blank?
  end

  def check_before_update
    validates_format_of :url_1, :with => URI::regexp(%w(http https))
    validates_format_of :url_2, :with => URI::regexp(%w(http https))
    validates_format_of :url_3, :with => URI::regexp(%w(http https))
  end

end
