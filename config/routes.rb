Rails.application.routes.draw do

  # create store_index_path & store_index_url accessor methods
  root 'store#index', as: 'store_index'

  resources :products


  # root 'welcome#index'
  get 'welcome/index'

  get 'say/hello'

  resources :articles

  get 'say/goodbye'

  # todo where to put root route?? order matters??

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
