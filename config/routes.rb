SocialCinemaNet::Application.routes.draw do

  resources :top_users


  resources :create_users_archives


  resources :u_ratings


  match 'search' => 'info#search'
  
  match 'advanced_search' => 'info#advanced_search'
  match 'advanced_search_result' => 'info#advanced_search_result'
  
  match 'register' => 'users#register', :via => :get
  match 'register' => 'users#create_user', :via => :post, :as => 'create_user'
  match 'logout' => 'users#logout', :via => :delete, :as => 'logout'
  match 'login' => 'users#new_session', :via => :post, :as => 'new_session'
  match 'login' => 'users#login', :as => 'login'
  
  match 'rate' => 'info#rate_it'
  
  match 'movies' => 'movies#index'
  match 'movie/imdb/update' => 'info#ajax_imdb_update'
  match 'movie/:id' => 'movies#show', :as => 'movie_show'
  match 'movie/:id/rate' => 'movies#rate', :as => 'movie_rate'
  
  match 'genres' => 'genres#index'
  match 'genres/:id' => 'genres#show', :as => 'genre_show'
  
  match 'users' => 'users#index'
  match 'user/myaccount' => 'users#myaccount', :as => 'myaccount'
  match 'user/myaccount/edit' => 'users#myaccountedit', :via => :put, :as => 'edit_my_account'
  match 'user/myaccount/changepassword' => 'users#change_password', :as => 'change_password'
  match 'user/myaccount/changepassword/action' => 'users#change_password_action', :via => :put, :as => 'change_password_action'
  match 'user/myaccount/delete_curr_user' => 'users#delete_curr_user', :via => :delete, :as => 'delete_curr_user'

  match 'actors' => 'people#actors', :as => 'actors'
  match 'actor/:id' => 'people#actor', :as => 'actor'
  match 'directors' => 'people#directors', :as => 'directors'
  match 'director/:id' => 'people#director', :as => 'director'
  
  match 'oscars' => 'oscars#index', :as => 'oscars'
  match 'oscar/:id' => 'oscars#show', :as => 'oscar_show'
  match 'oscar/:id/m_winner/:year' => 'oscars#m_nom_winner', :as => 'm_nom_winner'
  match 'oscar/:id/p_winner/:year' => 'oscars#p_nom_winner', :as => 'p_nom_winner'
  match 'oscar/:id/m_nom/:year' => 'oscars#m_nom', :as => 'm_nom'
  match 'oscar/:id/p_nom/:year' => 'oscars#p_nom', :as => 'p_nom'
  
  match 'movie/imdb/global_update' => 'info#ajax_imdb_global_update', :as => 'imdb_global_update'
  
  root :to => 'info#index'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
