Politics411::Application.routes.draw do  
  
  get "legislation/grab_xml"

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"
  
  resources :users
  match "/people/index" => "people#index"
  resources :sessions
  
  resources :contributors_interest_group_sectors

  resources :contributors_interest_groups

  resources :contributors_pacs

  resources :political_offices

  resources :earmarks

  resources :sponsored_legislations

  match "/people/all" => "people#all"
  
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

  get "industry_contributors/new"

  get "industry_contributors/show"

  get "industry_contributors/_form"

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
