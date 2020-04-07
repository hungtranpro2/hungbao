Rails.application.routes.draw do

	root "static_pages#index"
  mount ActionCable.server => "/cable"

	resources :static_pages
  resources :room_chats
  resources :messages
  resources :profiles, only: [:edit, :update]
  resources :message_notifications, only: [:index]
  resources :reset_passwords, only: [:edit, :update]
  resources :requests
  resources :reports
  resources :manage_projects
  resources :add_members
  resources :company_projects do
    resources :tasks
  end
  resources :project_members
  resources :add_project_managers
  resources :add_project_members
  resources :add_project_divisions
  resources :manage_divisions
  resources :show_projects
  resources :show_profiles
  resources :project_divisions
  resources :show_reports
  resources :approval_requests

  devise_for :users
  # get 'static_pages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
