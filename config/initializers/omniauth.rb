require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'], scope: 'playlist-modify-public playlist-read-private user-follow-read'
end

OmniAuth.config.allowed_request_methods = [:post,:get]