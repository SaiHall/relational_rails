Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/new', to: 'restaurants#new'
  get '/restaurants/:id', to: 'restaurants#show'
  get '/restaurants/:id/edit', to: 'restaurants#edit'

  get '/dishes', to: 'dishes#index'
  get '/dishes/:id', to: 'dishes#show'
  get '/dishes/:id/edit', to: 'dishes#edit'

  get '/restaurants/:restaurant_id/dishes', to: 'restaurant_dishes#index'
  get '/restaurants/:restaurant_id/dishes/new', to: 'restaurant_dishes#new'

  post '/restaurants/new', to: 'restaurants#create'
  post '/restaurants/:id/dishes/new', to: 'restaurant_dishes#create'

  patch '/restaurants/:id', to: 'restaurants#update'
  patch '/dishes/:id', to: 'dishes#update'

  delete '/restaurants/:id', to: 'restaurants#delete'
  delete '/dishes/:id', to: 'dishes#delete'
end
