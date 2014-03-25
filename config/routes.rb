Exusmed::Application.routes.draw do
  get "relationships/create"
  get "relationships/destroy"
  match 'members/insurance/new' => 'members#add_insurance', :via => :post 
  match 'members/:id/insurance/new' => 'members#add_insurance', :via => :post
  match '/invite_provider' => 'patients_providers#invite_provider', :via => :get
  match '/email_deliver' => 'patients_providers#email_deliver', :via => :post
  match '/search_details' => 'patients_providers#search_details', :via => :get
  match '/show_provider' => 'patients_providers#show_provider', :via  => :get
  match '/remove_insurance' => 'members#remove_insurance', :via => :get
  match '/remove_join_doc' => 'patients_providers#remove_join_doctor', :via => :get
  match '/join_provider' => 'patients_providers#join_provider', :via => :post
  match '/redir_index' => 'patients_providers#redir_index', :via => :get
  match '/search_members' => 'relationships#search_members', :via => :get
  match '/show_member' => 'relationships#show_member', :via => :get
  match '/join_party' => 'relationships#create', :via => :post
  match '/remove_join_relative' => 'relationships#destroy', :via => :delete

  get 'home/index'
  get 'patients_providers/show_provider'

  devise_for :users, :controllers => { :registrations => "registrations" }
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :doctors
  resources :patients_providers, :only => :index

  resources :members do
    resources :insurances,:appointments
  end

  root 'home#index'
  
end
