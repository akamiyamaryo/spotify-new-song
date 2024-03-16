require 'rspotify'
class MusicsController < ApplicationController
    def index
    end

    def search
        @danceability = []
        @energy =[]
        @tempo = []
        @ja = RSpotify::Recommendations.available_genre_seeds
        playlist = RSpotify::Playlist.find_by_id(params[:playlist].split("/").last)
        tracks = playlist.tracks
        if tracks.present?
            tracks.each do |track|
            audio = track.audio_features
            @energy << audio.energy
            @tempo << audio.tempo
            end
        end
        @e = @energy.sum/@energy.length.round(3)
        @t = @tempo.sum/@tempo.length.round(3)
        recommendations = RSpotify::Recommendations.generate(limit: 20,target_popularity: 100,
        seed_genres: [params[:genre]],target_energy: @e,target_tempo: @t)
        # tracks_uri = []
        # recommendations.tracks.each do |track|
        #     tracks_uri << track.uri
        # end
        # playlist.add_tracks!(tracks_uri)
        @tracks = recommendations.tracks
    end
    def spotify
        # track = RSpotify::Track.find('2UzMpPKPhbcC8RbsmuURAZ')
        # spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        # s = spotify_user.create_playlist!('my-awesome-playlist', public: true,collaborative: false)
        albums_limit = []
        albums = []
        tracks = {}
        @tracks_limit = []
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        followed_artists = spotify_user.following(type: 'artist', limit: 50)
        followed_artists.each do |artist|
            albums << artist.albums(limit: 50,album_type: "album")
            albums << artist.albums(limit: 50,album_type: "single")
        end

        albums.flatten!.each do |album|
            if album.release_date.to_s.slice(0..3).to_i >= Date.today.prev_year.to_s.slice(0..3).to_i
                albums_limit << album
            end
        end

        albums_limit.each do |album|
            tracks[album.release_date] = album.tracks(limit: 50)
        end

        tracks.each do |key,value|
            value.each do |track|
                if !Music.find_by(link: track.uri)
                    t = Music.new(artist_name:track.played_at ,track_name: track.name,link: track.uri,release_date:key)
                    if !t.save
                        render 'search', status: :unprocessable_entity
                    end
                    @tracks_limit << t
                end
            end
        end
    end
end
  
