Rails.application.routes.draw do
  # root 'welcome#index' tells Rails to map requests to the root of the application to the welcome controller's index action
  root 'welcome#index'

  get 'welcome/index'

  get 'say/hello'

  get 'say/goodbye'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
