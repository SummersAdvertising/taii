class AdminController < ApplicationController
	
	before_filter :authenticate_admin!
	
	after_action :clear_flash
	
	before_filter :set_locale
		
	def set_locale
		# 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
  	if params[:locale]
    	session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
  
  
private
	def clear_flash
		flash.delete(:warning)
	end

end
