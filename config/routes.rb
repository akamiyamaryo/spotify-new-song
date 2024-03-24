Rails.application.routes.draw do
  devise_for :users
  root to: "musics#index"
  get '/auth/spotify/callback', to: 'musics#spotify'
  get "/search", to: "musics#search"
end
