Rails.application.routes.draw do
  post '/search', to: 'visitors#search'

  root to: 'visitors#index'
end
