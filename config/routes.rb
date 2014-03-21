Exusmed::Application.routes.draw do
  match 'members/insurance/new' => 'members#add_insurance', :via => :post 
  match 'members/:id/insurance/new' => 'members#add_insurance', :via => :post
  match '/invite_provider' => 'patients_providers#invite_provider', :via => :get
  match '/email_deliver' => 'patients_providers#email_deliver', :via => :post
  match '/search_details' => 'patients_providers#search_details', :via => :get

  match '/remove_insurance' => 'members#remove_insurance', :via => :get
  match '/remove_join_doc' => 'patients_providers#remove_join_doctor', :via => :get


  get 'home/index'

  devise_for :users, :controllers => { :registrations => "registrations" }
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :doctors
  resources :patients_providers

  resources :members do
    resources :insurances,:appointments
  end

  root 'home#index'
  
end
