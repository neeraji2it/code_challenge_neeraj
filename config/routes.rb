Rails.application.routes.draw do
 
  namespace :api, defaults: { format: :json } do
  	namespace :v1 do
	    resources :web_data do
	      collection do 
	        post 'get_web_source'
	      end
	    end
	  end
  end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end