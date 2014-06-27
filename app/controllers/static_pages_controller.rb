class StaticPagesController < ApplicationController
	respond_to :html
  def index
  		#I18n.locale = params[:locale]
	  	#@hqlevelsRoot = Hqlevel.new.return_root_node()    
  end
  
  def show
  
	  if params[ :page ].nil?
			redirect_to :index
		end
		
		respond_to do | format |
			format.html { render :template => 'static_pages/' + params[ :page ] }# rescue redirect_to '/errors' }
		end
		
  end
  
  def set_locale
  
  	if params[:locale]
    	session[:locale] = params[:locale]
    	redirect_to root_url # :back
    end

    I18n.locale = session[:locale] || I18n.default_locale
    		
  end
  
end
