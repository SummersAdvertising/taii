#encoding: utf-8
class Hqlevel < ActiveRecord::Base
	translates :name
		
	has_many :hqproducts, -> { order('ranking, created_at') } ,dependent: :destroy
	
	#self join
	belongs_to :daddy, :class_name => "Hqlevel"#, :foreign_key => 'parent', touch: true
	#<% cache levelsib do%>
	has_many :children, :class_name => "Hqlevel", :foreign_key => 'parent'
  
  
	
	scope :top_level, -> { where(:parent => 0, :locale => I18n.locale) }	
	
	#validation
	validates_presence_of :name
	#return a tree of descendents [without] root node (in DFS way)
  #each node has every columns' data of this hqlevel
  def descendents

	  #children.preload(:parent).each do |child|  child.descendents end
	 children.each do |child|
      [child] + child.descendents
    end
end

  #all parent level
  # def ancestors(root)
#   	startfrom = self.id
#   	result = ""
#     while  startfrom != root do
# 	    result += (Hqlevel.where(id: startfrom).select([:id]))[0][:id].to_s + ","
# 	    startfrom -= 1
# 	end
# 	return Hqlevel.where( id: result.split(","))
#   end
   
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
  
  #return all node at same level besides itselft
  def find_my_siblings
  	Hqlevel.where(level: self.level, locale: I18n.locale).where.not(id: self.id).select(:id, :level) 
  end
  
  #return one level only
  #should be useful to create subfolder
  def find_my_direct_childrent
	  # globalize 後使用
	  #Hqlevel.where("level="+(self.level+1).to_s+" and parent="+self.id.to_s).order('ranking DESC, id').select([:id, :level,:updated_at])  	
  	  #還沒使用 globalize 前使用
#   	  Hqlevel.where("level="+(self.level+1).to_s+" and parent="+self.id.to_s).order('ranking , id').select([:id, :name, :level,:ranking,:updated_at])  	
   	  Hqlevel.where("level="+(self.level+1).to_s+" and parent="+self.id.to_s+" and locale='"+ I18n.locale.to_s+"'").order('ranking, id').select(:id, :ranking ,:level,:updated_at,:chaos)  	
  end
  
  def find_papa
  		
  end
  #should be useful to create breadcrum
  def find_my_direct_parent()
  	
		  root = Hqlevel.return_root_node_on_demand(I18n.locale).id.to_i
  		result = "#{self.id.to_s},"  
  		currentRoot = self.parent.to_i
  		currentNode = self

  		while currentRoot > root do
  			result = "#{result}#{currentNode.parent},"
  			currentNode = Hqlevel.find(currentNode.parent)
  			currentRoot = currentNode.parent.to_i
  		end
  		result = "#{result}#{root},"
  		return Hqlevel.where( id: result.split(","))
	  
	  #Hqlevel.where("id=" + :id.to_s).select([:id, :name, :level,:updated_at])  	
  end
    
  def return_root_node
  	return Hqlevel.find_by('parent=0 and '+"locale = '"+I18n.locale.to_s+"'")
  end
  
   def self.return_root_node_on_demand(locale)
   	return Hqlevel.find_by("parent=0 and locale='#{locale}'")
  end

end
