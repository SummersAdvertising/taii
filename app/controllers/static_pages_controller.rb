class StaticPagesController < ApplicationController

  def index
	  	@hqlevelsRoot = Hqlevel.new.return_root_node()    
  end

end
