Exusmed::Application.routes.draw do
  match 'members/insurance/new' => 'members#add_insurance', :via => :post 
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
