Taii::Application.routes.draw do


  
	scope ':locale', :locale => /en|zh_TW|zh_CN|ja/ do
		resources :hqlevels
		resources :brlevels	
	  
	  resources :hqproducts do 
	  	member do
				get 'fetch' , :action => 'fetch'
			end
	  end
		
		resources :brproducts do 
	  	member do
				get 'fetch' , :action => 'fetch'
			end
	  end

	end

  resources :announcements do
  	member do 
  	 get 'fetch', :action => 'fetch'
  	end
  end
  
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
			
			resources :organizations do 
				member do
					patch 'multiple_reorder' , :action => 'multiple_reorder'
				end
			end

			resources :representatives do
				member do
					patch 'multiple_reorder' , :action => 'multiple_reorder'
				end
			end

		  resources :announcements do
		  	member do
					patch 'multiple_reorder' , :action => 'multiple_reorder'
				end
		  end
			
			resources :banners do
			  member do
			    patch 'multiple_reorder' , :action => 'multiple_reorder'
			  end
			end

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
	  
  resources :investors, :controller => :investors , only: [:annualreport, :dividend_history, :financialreport, :majorresolution, :financialprojection, :monthlyrevenuereport, :majorpolicy, :index] do 
  	collection do
   		get 'annualreport', :action => :annualreport, :as => :annualreport
   		get 'shareholder', :action => :shareholder, :as => :shareholder
   		get 'dividend_history', :action => :dividend_history, :as => :dividend_history
   		get 'financialreport', :action => :financialreport, :as => :financialreport
   		get 'majorresolution', :action => :majorresolution, :as => :majorresolution
   		get 'financialprojection', :action => :financialprojection, :as => :financialprojection
	  	get 'monthlyrevenuereport/viewbymonth/:fiscal_month', :action => :monthlyrevenuereport, :as => :monthlyrevenuereport , :constraints => {:fiscal_month => /([1-9]|1[012])/ }
	  	get 'majorpolicy', :action => :majorpolicy, :as => :majorpolicy
	  	get ':investor', :action => :show, :as => :investor
  	end
  end
  
  get 'contactus' => "contact#contactus"
  
  get 'set_locale/:locale' => "static_pages#set_locale", :as => :set_locale, :locale => /en|zh_TW|zh_CN|ja/
	post 'search' => "search#index", :as => :search
	#resources :search, only: [:index]
	root :to => 'static_pages#index'
  #root :to => 'static_pages#construct'
  
	get '(*url)'	 => 'errors#index'
	#  end of front end
end
