Rails.application.routes.draw do

	root "room_chats#index"
  mount ActionCable.server => "/cable"

	resources :static_pages
  resources :room_chats
  resources :messages
  resources :profiles, only: [:edit, :update]
  resources :message_notifications, only: [:index]
  resources :reset_passwords, only: [:edit ,:update]
  devise_for :users
  # get 'static_pages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
