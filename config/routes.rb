Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  devise_for :users

  root to: 'home#index'

  get 'test/user'
  get 'test/admin'
  get 'home/index'
end
