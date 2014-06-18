class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
	  admin_hqlevel_path(Hqlevel.return_root_node_on_demand("zh_TW"), :locale => "zh_TW" )
	end
	
end
