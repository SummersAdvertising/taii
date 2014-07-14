class SearchController < ApplicationController

	def index
	  @hq_root_node = Hqlevel.return_root_node_on_demand("#{I18n.locale}")
	  @br_root_node = Brlevel.return_root_node_on_demand("#{I18n.locale}")
		
    #unless params[:search].blank?
      @hq_result = Hqproduct.search(params[:search])
  		@br_result = Brproduct.search(params[:search])
    #end

    #@hq_result = nil
    #@hq_result = nil

	end
	
end