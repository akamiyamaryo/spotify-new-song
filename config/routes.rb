Rails.application.routes.draw do
  root to: "musics#index"
  get '/auth/spotify/callback', to: 'musics#spotify'
  get "/search", to: "musics#search"
end
