Politics411::Application.routes.draw do  

  get "subcommittees/index"
  get "subcommittees/show"

  # ajax for legislation
  get "legislation/refresh"

  match "subcommittees/:id" => "subcommittees#show"

  get "contributor/show"

  get "committees/index"
  get "committees/manage"

  match "senators" => "people#senators"
  match "representatives" => "people#representatives"

  get "people/senators"
  get "people/representatives"
  get "people/refresh_officials"
  get "people/index"
  get "people/switch_to_representative_by_state"
  get "people/switch_to_representative_by_name"
  get "people/switch_to_representative_by_party"
  get "people/switch_to_senator_by_state"
  get "people/switch_to_senator_by_party"
  get "people/switch_to_senator_by_name"
  get "people/refresh_bubble_rect"

  # Routes for autocomplete api
  get "api/autocomplete/autocomplete_person_name"
  get "api/autocomplete/autocomplete_person_url"
  get "api/autocomplete/autocomplete_religion_name"
  get "api/autocomplete/autocomplete_university_name"
  get "api/autocomplete/autocomplete_organization_name"
  get "api/autocomplete/autocomplete_main_issues_name"
  get "api/autocomplete/autocomplete_issues_name"

  # people api
  get "api/people/index"

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"

  # Resourceful routes
  resources :main_issues
  resources :issues
  resources :committees
  resources :subcommittees
  resources :legislation
  resources :users
  resources :password_resets
  resources :sessions
  resources :contributors_interest_group_sectors
  resources :contributors_interest_groups
  resources :contributors_pacs
  resources :political_offices
  resources :earmarks
  resources :sponsored_legislations  
  resources :campaign_platforms
  resources :supporters
  resources :contributors
  resources :people  
  resources :articles 
  resources :attachments
  resources :personal_assets
  resources :transactions
  resources :litigations
  resources :accusations
  resources :endorsements
  resources :professional_experiences
  resources :business_associates
  resources :organizations
  resources :flip_flops
  resources :videos
  resources :family_members
  resources :religions
  resources :universities 
  resources :degrees

  root :to => "people#all"

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
  match ':controller(/:action(/:id(.:format)))'
end
