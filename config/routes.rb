Rails.application.routes.draw do
  root 'items#newest'
  
  resources :factories

  resources :customers

  namespace :pc do
    resources :items, only: [:index] do
      get :search, on: :collection
    end
  end

  resources :workpieces

  resources :procedures do
    get :search, on: :collection
    post :import, on: :collection
    resources :stages
  end

  scope :stages, controller: :stages do
    patch ':id/finish' => :finish, as: :finish_stage
    patch ':id/arrive' => :arrive, as: :arrive_stage
  end

  resources :items do
    collection do
      post :import
      get :export
      get :search
      get 'destroy_all_page', action: :destroy_all_page
      delete 'destroy_all', action: :destroy_all
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
