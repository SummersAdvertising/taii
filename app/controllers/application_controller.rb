class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_locale
		
	def set_locale
		# 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
  	if params[:locale]
    	session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  
  def after_sign_in_path_for(resource)
	  admin_hqlevel_path(Hqlevel.return_root_node_on_demand("zh_TW"), :locale => "zh_TW" )
	end
	
end
