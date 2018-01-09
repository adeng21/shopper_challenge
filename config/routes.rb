Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :applicants, only: [:new, :create, :edit] do
  	collection do
  		get :background_check
     	post :background_check_authorized
     	get :confirmation
  	end
  end

end
