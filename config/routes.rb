Rails.application.routes.draw do
  get 'wiki_page/random'
  resources :wiki_page

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  devise_for :users

  root to: 'home#index'

  # format: controller_name/controller_action
  get 'test/user'
  get 'test/admin'
  get 'home/index'
end
