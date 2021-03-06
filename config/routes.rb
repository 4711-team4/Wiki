Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users
  
  root to: 'wiki_page#index'
  
  get 'test/user'
  get 'test/admin'
  # get 'home/index'
  
  get 'wiki_page/random'
  post 'wiki_page/:id/lock', to: 'wiki_page#lock', as: 'wiki_page_lock'
  post 'wiki_page/:id/unlock', to: 'wiki_page#unlock', as: 'wiki_page_unlock'
  get 'revisions/show'

  resources :wiki_page do
    resources :revisions
  end

  resources :image, only: [:show]
  post 'image/:id/comment', to: 'comment#create', as: 'image_comment'

  # routes for admin stuff
  get 'admin/index'
  get 'admin/block_ip'
  get 'admin/unblock_ip'

end
