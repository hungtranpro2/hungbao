Rails.application.routes.draw do

	root "room_chats#index"
  mount ActionCable.server => "/cable"

	resources :static_pages
  resources :room_chats
  resources :messages

  devise_for :users
  get 'static_pages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
