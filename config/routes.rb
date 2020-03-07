Rails.application.routes.draw do
	root "room_chats#index"
  mount ActionCable.server => "/cable"

	resources :static_pages
  resources :room_chats
  resources :messages
end
