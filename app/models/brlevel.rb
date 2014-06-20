class Brlevel < ActiveRecord::Base
	translates :name
		
	has_many :brproducts, -> { order('ranking, created_at') }  ,dependent: :destroy
	
	#self join
	belongs_to :daddy, :class_name => "Brlevel", :foreign_key => 'parent'
	has_many :children, :class_name => "Brlevel", :foreign_key => 'parent'
	
	scope :top_level, -> { where(:parent => 0, :locale => I18n.locale) }	
	
	#important
	#SELECT brproducts.* FROM brproducts INNER JOIN brlevels ON brlevels.id = brproducts.brlevel_id
	#WHERE ( brproducts.brlevel_id = ? and brlevels.locale = ? )
	def self.with_products(levelid=1, locale=I18n.locale)
			Brproduct.with_translations(I18n.locale).joins(:brlevel).where(["brproducts.brlevel_id = ? and brlevels.locale = ?", levelid, locale ])
	end
  
  #return all node at same level besides itselft
  def find_my_siblings
  	Brlevel.where(level: self.level, locale: I18n.locale).where.not(id: self.id).select(:id, :level) 
  end
  
  def self.full_house
  	return Brlevel.where('parent=0')
  end
  
  #return one level only
  #should be useful to create subfolder
  def find_my_direct_childrent
  
   	  Brlevel.with_translations(I18n.locale).where("brlevels.level="+(self.level+1).to_s+" and brlevels.parent="+self.id.to_s+" and brlevels.locale='"+ I18n.locale.to_s+"'").order('brlevels.ranking, brlevels.id').select("brlevels.id, brlevels.ranking ,brlevels.level,brlevels.updated_at, brlevels.chaos, brlevel_translations.name")  	
  
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
  	return Brlevel.find_by('parent=0 and '+"locale = '"+I18n.locale.to_s+"'")
  end
  
   def self.return_root_node_on_demand(locale)
  	return Brlevel.find_by('parent=0 and '+"locale = '"+locale.to_s+"'")
  end
  
  #return a tree of descendents [without] root node (in DFS way)
  #each node has every columns' data of this brlevel
  def descendents

		  #children.preload(:parent).each do |child|  child.descendents end
		 children.each do |child|
	      [child] + child.descendents
	    end
   end
  #PRACTICE
  #return a tree of descendents [with] root node (in DFS way)  
  #each node has every columns' data of return brlevel
  def self_and_descendents
    [self] + descendents
  end
  #PRACTICE  
  #return a tree of descendents [with] root node (in DFS way)  
  #each node has only [name] column of return brlevel
  def descendent_names
     self_and_descendents.map(&:name).flatten 
  end
  
  #PRACTICE
  #return a tree of descendents [with] root node (in DFS way)  
  #each node contains pre-defined columns of return brlevel
  #take this as an example which will return [name] [parent] and [level]
  def descendent_keyinfo
  	 self_and_descendents.map{ |f|
		{ id: f.id, name: f.name, parent: f.parent, level: f.level}
		}.flatten
  end

end
