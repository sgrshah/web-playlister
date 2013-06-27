require 'sinatra/base'
require 'youtube_search'

require "./lib/artist"
require "./lib/song"
require "./lib/genre"
require "./lib/parse"

module Playlister
  class App < Sinatra::Base
    
    Parse.new.parse

    get '/' do
      erb :index
    end

    get '/artists' do
      @artists = Artist.all
      erb :artists
    end

    get '/songs' do
      @songs = Song.all
      erb :songs
    end

    get '/genres' do
      @genres = Genre.all
      erb :genres
    end

    get '/artists/:name' do
      @artist = Artist.find_by_name(params[:name])
      erb :artist
    end

    get '/songs/:name' do
      @song = Song.find_by_name(params[:name])
      @youtube_id = YoutubeSearch.search(params[:name]).first['video_id']
      erb :song
    end

    get '/genres/:name' do
      @genre = Genre.find_by_name(params[:name])
      erb :genre
    end
  
  end
end
