Rails.application.routes.draw do
  get 'wiki_page/random'
  get 'wiki_page/show'
  get 'wiki_page/edit'
  get 'wiki_page/update'
  get 'wiki_page/new'
  get 'wiki_page/list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  devise_for :users

  root to: 'home#index'

  get 'test/user'
  get 'test/admin'
  get 'home/index'
end
