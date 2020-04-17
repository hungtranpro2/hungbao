Rails.application.routes.draw do

	root "room_chats#index"
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
  resources :company_projects
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
  resources :division_projects
  resources :overview_companys
  resources :share_tasks
  resources :overview_divisions
  resources :overview_personals
  resources :errors, ony: [:index]
  resources :division_members
  resources :project_division_members
  resources :division_reports
  resources :division_tasks
  resources :add_task_users
  resources :personal_tasks
  resources :add_personal_tasks
  resources :my_calendars
  resources :my_works
  resources :user_managers
  resources :overview_projects
  resources :project_reports
  resources :project_tasks
  resources :project_requests
  resources :company_tasks
  resources :company_reports
  resources :company_members
  devise_for :users
  # get 'static_pages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
