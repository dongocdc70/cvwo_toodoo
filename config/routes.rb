Rails.application.routes.draw do
  resources :tasks do
  	get 'toggle_completed', on: :member
  end
	root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
