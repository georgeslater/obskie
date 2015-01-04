Rails.application.routes.draw do

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'

  resources :tracks

  devise_for :users, :controllers => { registrations: 'registrations'}
  devise_scope :user do
      get 'users/sign_up_success', as: :check_email
  end

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'albums#index'

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]
  
  resources :ratings, only: :create

  resources :users

  match '/search/albums', to: 'searches#get_albums', via: 'get'
  match '/search/tracks', to: 'searches#get_tracks', via: 'get'
  match '/search/artists', to: 'searches#get_artists', via: 'get'
  match '/submitAlbum', to: 'searches#submit', via: 'get'

  get 'albums/approval' => 'albums#approval', as: :non_approved

  get 'users/:id/albums/my_drafts' => 'users#drafts', as: :my_drafts

  get '/contribute' => 'contacts#become_contributor', as: :become_contributor

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :playlists do
    resources :comments
  end

  resources :albums do
    member do
      patch 'approve'
      patch 'reject'
    end
    resources :comments
  end

  resources :artists do
    resources :albums do
      resources :comments
      resources :tracks
    end
  end

  get "sitemap.xml" => "home#sitemap", format: :xml, as: :sitemap
  get "robots.txt" => "home#robots", format: :text, as: :robots

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
