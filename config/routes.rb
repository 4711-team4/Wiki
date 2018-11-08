Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

  get 'wiki_page/random'
  resources :wiki_page

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'home#index'

  # format: controller_name/controller_action
  get 'test/user'
  get 'test/admin'
  get 'home/index'


  # routes for admin stuff
  get 'admin/index'
  get 'admin/block_ip'
  post 'wiki_page/:id/lock', to: 'wiki_page#lock', as: 'wiki_page_lock'
  post 'wiki_page/:id/unlock', to: 'wiki_page#unlock', as: 'wiki_page_unlock'

end
