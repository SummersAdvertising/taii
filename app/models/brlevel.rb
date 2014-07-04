class Brlevel < ActiveRecord::Base
	translates :name
		
	has_many :brproducts, -> { order('ranking, created_at') }  ,dependent: :destroy
	
	#validation
	validates_presence_of :name
	
	#self join
	belongs_to :daddy, -> { where(locale: I18n.locale) }, :class_name => "Brlevel", :foreign_key => 'parent'#, :foreign_key => 'parent', touch: true
	#<% cache levelsib do%>
	has_many :children, -> { where(locale: I18n.locale) }, :class_name => "Brlevel", :foreign_key => 'parent'

	#default_scope { where(locale: I18n.locale) }
	scope :top_level, -> { where(:parent => 0, :locale => I18n.locale) }	
	
	#important for font end
	#SELECT brproducts.* FROM brproducts INNER JOIN brlevels ON brlevels.id = brproducts.brlevel_id
	#WHERE ( brproducts.brlevel_id = ? and brlevels.locale = ? )
	def self.with_products(levelid=1, locale=I18n.locale)
			Brproduct.with_translations(I18n.locale).joins(:brlevel).where(["brproducts.brlevel_id = ? and brlevels.locale = ?", levelid, locale ]).order('brproducts.ranking, brproducts.created_at')
	end
	
	def self.with_products_for_front(levelid, locale=I18n.locale)
			Brproduct.with_translations(I18n.locale).joins(:brlevel).where(["brproducts.brlevel_id = ? and brlevels.locale = ? 	and brproducts.showatfront = 200", levelid, locale ])
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
  	
  	 self.findpapa
  	 directparents = @@directparent.dup
  	 @@directparent.clear
  	 
  	 return directparents
  	 
  end
  
  #find direct parent levle mainly for breadcrumb
	@@directparent = []
	def findpapa

	  if self.parent == 0
  			@@directparent << self
 			 return @@directparent
 		end		
 		
		if self.parent > 0	
 				@@directparent << self
				daddy.findpapa
    end
		
	end
	    
  def return_root_node
  	return Brlevel.find_by('parent=0 and '+"locale = '"+I18n.locale.to_s+"'")
  end
  
   def self.return_root_node_on_demand(locale)
   	return Brlevel.find_by("parent=0 and locale='#{locale}'")
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
  
  # FOR FRONT END: [brlevels.id, brlevel_translations.name, brproducts.id, brproduct_translations.name]
  def self.get_all_level_product_pairs()
	  #sql = " SELECT brlevels.id, brlevel_translations.name, brproducts.id, brproduct_translations.name FROM brlevels LEFT JOIN (brproducts, brlevel_translations, brproduct_translations) ON (brlevels.id = brproducts.brlevel_id AND brlevel_translations.brlevel_id = brlevels.id AND brproduct_translations.brproduct_id = brproducts.id ) WHERE brproducts.showatfront = 200 AND brlevels.locale = '#{I18n.locale}' ORDER BY brlevels.ranking, brproducts.ranking "
  	#local
  	sql = "SELECT brlevels.id, brlevel_translations.name, brproducts.id, brproduct_translations.name FROM brlevels LEFT JOIN brproducts, brlevel_translations, brproduct_translations WHERE brlevels.id = brproducts.brlevel_id AND brlevel_translations.brlevel_id = brlevels.id AND brproduct_translations.brproduct_id = brproducts.id AND brproducts.showatfront = 200 AND brlevels.locale = '#{I18n.locale}' ORDER BY brlevels.ranking, brproducts.ranking"
  	
  	return records_array = ActiveRecord::Base.connection.execute(sql)
  end
  
  #FOR FRONT END: [brlevels.id, brlevels.level, brlevels.parent, brlevels.name]
  def self.get_level_hierarchy()
	  #sql = "SELECT brlevels.id, brlevels.level, brlevels.parent, brlevel_translations.name FROM brlevels LEFT JOIN brlevel_translations ON brlevels.id = brlevel_translations.brlevel_id WHERE brlevels.locale = '#{I18n.locale}' AND brlevels.parent != 0 ORDER BY brlevels.ranking"
	  #local
	  sql = "SELECT brlevels.id, brlevels.level, brlevels.parent, brlevel_translations.name FROM brlevels LEFT JOIN brlevel_translations WHERE brlevels.id = brlevel_translations.brlevel_id AND brlevels.locale = '#{I18n.locale}' AND brlevels.parent != 0 ORDER BY brlevels.ranking"
	  
	  return records_array = ActiveRecord::Base.connection.execute(sql)
	end

end
