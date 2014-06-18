Taii::Application.routes.draw do


  #resources :majorpolicies
  #resources :financialprojections
  #resources :announcements
  #resources :dividend_histories
  #resources :revenue_items
  #resources :monthlyrevenuereports
  #resources :brproducts
	#resources :brlevels
	#resources :hqproducts
	#resources :hqlevels
	#resources :financialreports
	devise_for :admins

	namespace :admin do
	
  		authenticated :admin do
	  		root :to => "admins#index"
	  	end
	  	
	  	
		get '/' => 'admins#index'
		
		resources :admins
	
		resources :financialreports  do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end
		end
		
	  resources :majorresolutions do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end
		end
	
	  resources :annualreports  do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end
		end

# let historyrevenuereport upload binding with monthlyrevenuereports		=> no
# they want shit, then give them shit
		resources :historyrevenuereports do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end
		end
		
		resources :monthlyrevenuereports  do
			member do 
				get 'edit/bymonth/:fiscal_month'  => 'monthlyrevenuereports#editbymonth',:as => "editbymonth", :constraints => {:fiscal_month => /([1-9]|1[012])/ }
			end
			# collection do
# 				get 'edithistoryrevenue', action: 'edithistoryrevenue'
# 			end
		end 
		
		resources :revenue_items do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
				get 'createDefaultItems' , :action => 'createDefaultItems'
			end 
		end
		
	  resources :dividend_histories do
		  member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end
		end
		
	  resources :announcements
    
    resources :financialprojections do
		    member do
						patch 'create_attachment' , :action => 'create_attachment'
		    end
    end
	  
	  resources :majorpolicies do 
	  	member do
						patch 'create_attachment' , :action => 'create_attachment'
		    end
    end
	  
		resources :attachments do
			member do
				patch 'multiple_reorder' , :action => 'multiple_reorder'
			end 
		end

	#test example
	#admin_organizations GET    
	#/admin/:locale/organizations(.:format)            
	#admin/organizations#index {:locale=>/en|zh_TW|zh_CN|ja/}
		scope ':locale', :locale => /en|zh_TW|zh_CN|ja/ do
			
			resources :brlevels  do
				member do
					patch 'reorder'
					patch 'multiple_reorder' , :action => 'multiple_reorder'
				end 
			end	
			
			resources :brproducts do
				member do
					patch 'reorder'
					patch 'multiple_reorder' , :action => 'multiple_reorder'
					patch 'create_attachment' , :action => 'create_attachment'
				end 
			end
			
			resources :hqlevels do
				member do
			    	patch 'reorder'
			    	patch 'multiple_reorder' , :action => 'multiple_reorder'
			    end 
			 end
			 
			 resources :hqproducts do
				member do
					patch 'reorder'
					patch 'multiple_reorder' , :action => 'multiple_reorder'
					patch 'create_attachment' , :action => 'create_attachment'
				end 
			end
			
			resources :organizations
			resources :representatives
			
			resources :photos do
		  		member do
		  			post :resize
		  		end
		  	end
		  			  	
		  	post 	'peditor/:id/createPhoto'				=> 'peditor#createPhoto'
		    delete 'peditor/deletePhoto/:id'				=> 'peditor#destroyPhoto' 			  	
		    
		end # end of locale scope
		
	  post 	'peditor/:id/createPhoto'				=> 'peditor#createPhoto'
    delete 'peditor/deletePhoto/:id'				=> 'peditor#destroyPhoto'
    
  end # end of admin namespace

  # start of front end 
	resources :pages, :controller => :static_pages do 
		collection do
			get ':page', :action => :show, :as => :page
		end
	end
  
	root :to => 'static_pages#index'
  #root :to => 'static_pages#construct'
  
	#get '(*url)'	 => 'errors#index'
	#  end of front end
end
