Rails.application.routes.draw do
  # get 'metro_line_metro_stops/index'

  # get 'metro_line_metro_stops/import'

  # get 'metro_stops/index'

  # get 'metro_stops/import'

  # get 'metro_lines/index'

  # get 'metro_lines/import'

  get 'bus_line_bus_stops/index'

  get 'bus_line_bus_stops/import'

  get 'bus_stops/index'

  get 'bus_stops/import'

  get 'bus_lines/index'

  get 'bus_lines/import'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'challenges' => 'static_pages#challenges'

  get 'signup'  => 'users#new'

  #get 'home' => 'users#home'

  get    'login'   => 'sessions#new'

  post   'login'   => 'sessions#create'
  
  delete 'logout'  => 'sessions#destroy'

  post 'users/:id/' ,to: 'users#profileAfterChoices',as: 'users_profile_after_choices'

  post 'users/:id/checkin_start', to: 'users#checkin_start', as: 'users_checkin_start'
  post 'users/:id/checkin_end', to: 'users#checkin_end', as: 'users_checkin_end'

  get 'users/:id/' ,to: 'users#profile',as: 'users_profile'

  post 'users/:id/choices',to: 'users#choices',as: 'users_choices'

  get 'users/:id/addErrands',to: 'users#addErrands',as: 'users_addErrands'

  resources :users 

  resources :account_activations, only: [:edit]

  resources :errands

  post 'errands/:id/' => 'errands#show'
  
  # get 'auth/:provider/callback', to: 'sessions#create_facebook'
  # get 'auth/failure', to: redirect('/')
  # get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :metro_lines do
    collection {post :import}
  end
  
  resources :metro_stops do
    collection {post :import}
  end

  resources :metro_line_metro_stops do
    collection {post :import}
  end

  resources :bus_lines do
    collection {post :import}
  end
  
  resources :bus_stops do
    collection {post :import}
  end

  resources :bus_line_bus_stops do
    collection {post :import}
  end

  resources :locations, only: [] do
    collection do
      get :search
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
