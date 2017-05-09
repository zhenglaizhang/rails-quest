Rails.application.routes.draw do
  get 'welcome/index'

  get 'say/hello'

  resources :articles

  get 'say/goodbye'

  # todo where to put root route?? order matters??
  # root 'welcome#index' tells Rails to map requests to the root of the application to the welcome controller's index action
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
