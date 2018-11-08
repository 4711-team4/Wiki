Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount(Ckeditor::Engine => '/ckeditor')
  
  devise_for :users
  
  root to: 'home#index'
  
  get 'test/user'
  get 'test/admin'
  get 'home/index'
  
  resources :wiki_page do
    resources :revisions
  end

  post 'wiki_page/:id/lock', to: 'wiki_page#lock', as: 'wiki_page_lock'
  post 'wiki_page/:id/unlock', to: 'wiki_page#unlock', as: 'wiki_page_unlock'
  get 'wiki_page/random'
  get 'revisions/show'
end
