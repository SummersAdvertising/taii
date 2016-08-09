class Representative < ActiveRecord::Base

  translates :division, :name, :phone, :fax, :mobile, :email
    
  belongs_to :organization

  default_scope { order('ranking, created_at') }

  validates :division, :presence => true 
  validates :name, :presence => true 
  #validates :phone, :presence => true
  #validates :mobile, :presence => true
  #validates :email, :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i}
    
end
