#encoding: utf-8
class Hqlevel < ActiveRecord::Base
	translates :name
		
	has_many :hqproducts, -> { order('ranking, created_at') } ,dependent: :destroy
	
	#self join
	belongs_to :daddy, -> { where(locale: I18n.locale) }, :class_name => "Hqlevel", :foreign_key => 'parent'#, :foreign_key => 'parent', touch: true
	#<% cache levelsib do%>
	has_many :children, -> { where(locale: I18n.locale) }, :class_name => "Hqlevel", :foreign_key => 'parent'
  
  #default_scope { includes(:translations) }
	 #取代 return_root_node_ondemand
	 scope :top_level, -> { where(:parent => 0, :locale => I18n.locale) }	
	#validation
	validates_presence_of :name
	
	#important
	#SELECT hqproducts.* FROM hqproducts INNER JOIN hqlevels ON hqlevels.id = hqproducts.hqlevel_id
	#WHERE ( hqproducts.hqlevel_id = ? and hqlevels.locale = ? )
	def self.with_products(levelid=1, locale=I18n.locale)
			Hqproduct.with_translations(I18n.locale).joins(:hqlevel).where(["hqproducts.hqlevel_id = ? and hqlevels.locale = ?", levelid, locale ]).order('hqproducts.ranking, hqproducts.created_at')
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
  
  @@tree = []
  def dump_all #DFS
    @@tree.clear
  	root = Hqlevel.return_root_node_on_demand(I18n.locale)
  	root.find_my_direct_childrent.each do | level |
  			#@@tree << self
  			level.collect		
  	end
  	
  	tree = @@tree.dup
  	@@tree.clear
    return tree
    
  end
  
  def collect
  	self.children.each do | child |
  		@@tree << child
  		child.collect
  	end
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
	
	def self.find_by_level(level)
		Hqlevel.with_translations(I18n.locale).where(["hqlevels.level = ?",level])
	end
	
	def dump
		#fails
		#a = Hqlevel.with_translations(I18n.locale).preload(Hqproducts.with_translations(I18n.locale))
		#a = Hqlevel.includes(:hqproducts).with_translations(I18n.locale).load
		#a = Hqlevel.includes(:hqproducts).load
		Hqlevel.where("locale = '#{I18n.locale}' and parent != 0 ").includes(:hqproducts)
		#a = Hqlevel.where('locale = "zh_TW"').includes(:hqproducts)
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
  
  # FOR FRONT END: [hqlevels.id, hqlevel_translations.name, hqproducts.id, hqproduct_translations.name]
  def self.get_all_level_product_pairs()
    
    if Rails.env.production?
      sql = " SELECT hqlevels.id, hqlevel_translations.name, hqproducts.id, hqproduct_translations.name FROM hqlevels LEFT JOIN (hqproducts, hqlevel_translations, hqproduct_translations) ON (hqlevels.id = hqproducts.hqlevel_id AND hqlevel_translations.hqlevel_id = hqlevels.id AND hqproduct_translations.hqproduct_id = hqproducts.id ) WHERE hqproducts.showatfront = 200 AND hqlevels.locale = '#{I18n.locale}' ORDER BY hqlevels.ranking, hqproducts.ranking "
    else
      #local
  	  sql = "SELECT hqlevels.id, hqlevel_translations.name, hqproducts.id, hqproduct_translations.name FROM hqlevels LEFT JOIN hqproducts, hqlevel_translations, hqproduct_translations WHERE hqlevels.id = hqproducts.hqlevel_id AND hqlevel_translations.hqlevel_id = hqlevels.id AND hqproduct_translations.hqproduct_id = hqproducts.id AND hqproducts.showatfront = 200 AND hqlevels.locale = '#{I18n.locale}' ORDER BY hqlevels.ranking, hqproducts.ranking"
  	end

  	return records_array = ActiveRecord::Base.connection.execute(sql)
  end
  
  #FOR FRONT END: [hqlevels.id, hqlevels.level, hqlevels.parent, hqlevels.name]
  def self.get_level_hierarchy()
    
    if Rails.env.production?
	    sql = "SELECT hqlevels.id, hqlevels.level, hqlevels.parent, hqlevel_translations.name FROM hqlevels LEFT JOIN hqlevel_translations ON hqlevels.id = hqlevel_translations.hqlevel_id WHERE hqlevels.locale = '#{I18n.locale}' AND hqlevels.parent != 0 ORDER BY hqlevels.ranking"
	  else
      #local
	    sql = "SELECT hqlevels.id, hqlevels.level, hqlevels.parent, hqlevel_translations.name FROM hqlevels LEFT JOIN hqlevel_translations WHERE hqlevels.id = hqlevel_translations.hqlevel_id AND hqlevels.locale = '#{I18n.locale}' AND hqlevels.parent != 0 ORDER BY hqlevels.ranking"
	  end

	  return records_array = ActiveRecord::Base.connection.execute(sql)

	end
	  
end
