class StaticPagesController < ApplicationController
	respond_to :html
  def index
		@news = Announcement.with_translations(I18n.locale).limit(3)
    @banners = Banner.with_translations(I18n.locale).order(:ranking, :created_at)
    @banners_attachment_count = 0

    @banners.each do |banner|  
      @banners_attachment_count += 1 if banner.attachments.first
    end
    
		#I18n.locale = params[:locale]
  	#@hqlevelsRoot = Hqlevel.new.return_root_node()    
  end
  
  def show
  
	  if params[ :page ].nil?
			redirect_to :index
		end
		
		respond_to do | format |
			format.html { render :template => 'static_pages/' + params[ :page ]  rescue redirect_to '/errors' }
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
