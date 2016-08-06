Rails.application.routes.draw do
  filter :locale

  get '/about', to: 'home#about', as: :about

  # articles
  get '/articles' => redirect('/')
  get '/articles/:article', to: 'articles#show', as: :article

  get '/projects', to: 'projects#index'
  get '/projects/maze', to: 'projects#maze'

  root 'home#index'

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

end
