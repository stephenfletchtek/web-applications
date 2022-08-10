# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    # @albums = albums.map { |album| [album.title, album.release_year] }
    erb(:albums)
  end

  get '/albums/new' do
    erb(:albums_new)
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist = ArtistRepository.new
    album = repo.find(params[:id])
    @title = album.title
    @release_year = album.release_year
    @artist = artist.find(album.artist_id).name
    erb(:albums_id)
  end

  post '/albums' do
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo = AlbumRepository.new
    repo.create(new_album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    erb(:artists)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    erb(:artists_id)
  end

  post '/artists' do
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    repo = ArtistRepository.new
    repo.create(new_artist)
  end
end