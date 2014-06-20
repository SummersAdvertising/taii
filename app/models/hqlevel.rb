#encoding: utf-8
class Hqlevel < ActiveRecord::Base
	translates :name
		
	has_many :hqproducts, -> { order('ranking, created_at') } ,dependent: :destroy
	
	#self join
	belongs_to :daddy, :class_name => "Hqlevel", :foreign_key => 'parent'#, :foreign_key => 'parent', touch: true
	#<% cache levelsib do%>
	has_many :children, :class_name => "Hqlevel", :foreign_key => 'parent'
  
	 #取代 return_root_node_ondemand
	 scope :top_level, -> { where(:parent => 0, :locale => I18n.locale) }	
	
	#validation
	validates_presence_of :name
	
	#important
	#SELECT hqproducts.* FROM hqproducts INNER JOIN hqlevels ON hqlevels.id = hqproducts.hqlevel_id
	#WHERE ( hqproducts.hqlevel_id = ? and hqlevels.locale = ? )
	def self.with_products(levelid=1, locale=I18n.locale)
			Hqproduct.with_translations(I18n.locale).joins(:hqlevel).where(["hqproducts.hqlevel_id = ? and hqlevels.locale = ?", levelid, locale ])
	end
  
  #return all node at same level besides itselft
  def find_my_siblings
  	Hqlevel.where(level: self.level, locale: I18n.locale).where.not(id: self.id).select(:id, :level) 
  end
  
  def self.full_house
  	return Hqlevel.where('parent=0')
  end
  
	#important : with_translations first
  #return one level only
  #should be useful to create subfolder
  def find_my_direct_childrent
   	  Hqlevel.with_translations(I18n.locale).where("hqlevels.level="+(self.level+1).to_s+" and hqlevels.parent="+self.id.to_s+" and hqlevels.locale='"+ I18n.locale.to_s+"'").order('hqlevels.ranking, hqlevels.id').select("hqlevels.id, hqlevels.ranking ,hqlevels.level,hqlevels.updated_at, hqlevels.chaos, hqlevel_translations.name")  	
  end
  
  #should be useful to create breadcrum
  def find_my_direct_parent
  	
  	 directparents = self.findpapa.dup
  	 @@directparent.clear
  	 
  	 return directparents
  	 
  end
  
  #find direct parent levle mainly for breadcrumb
	@@directparent = []
	def findpapa
		if self.parent > 0	
				if daddy.parent != 0
						@@directparent << daddy
						daddy.findpapa
				end
		end 
		
 			 @@directparent << self
			 return @@directparent

	end
   
  
  def return_root_node
  	return Hqlevel.find_by('parent=0 and '+"locale = '"+I18n.locale.to_s+"'")
  end
  
   def self.return_root_node_on_demand(locale)
   	return Hqlevel.find_by("parent=0 and locale='#{locale}'")
  end
  
  # PRACTICE AREA #
  #return a tree of descendents [without] root node (in DFS way)
  #each node has every columns' data of this hqlevel
  def descendents
	  #children.preload(:parent).each do |child|  child.descendents end
	 children.each do |child|
      [child] + child.descendents
    end
	end
   
  #PRACTICE
  #return a tree of descendents [with] root node (in DFS way)  
  #each node has every columns' data of return hqlevel
  def self_and_descendents
    [self] + descendents
  end
  #PRACTICE  
  #return a tree of descendents [with] root node (in DFS way)  
  #each node has only [name] column of return hqlevel
  def descendent_names
     self_and_descendents.map(&:name).flatten 
  end
  
  #PRACTICE
  #return a tree of descendents [with] root node (in DFS way)  
  #each node contains pre-defined columns of return hqlevel
  #take this as an example which will return [name] [parent] and [level]
  def descendent_keyinfo
  	 self_and_descendents.map{ |f|
		{ id: f.id, name: f.name, parent: f.parent, level: f.level}
		}.flatten
  end
  
end
