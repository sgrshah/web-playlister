require_relative "lib/artist"
require_relative "lib/song"
require_relative "lib/genre"
require_relative "lib/parse"
require "erb"

class OnlineJukebox
	Artist.reset_artists
  Genre.reset_genres
  Song.reset_songs

	Parse.new.parse
	
	class Index


	def get_binding
		binding
	end

	# def display_artists
	# 	ERB.new(File.read('lib/views/artists.html.erb')).result(get_binding)
	# end

	# def display_genres
	# 	ERB.new(File.read('lib/views/genres.html.erb')).result(get_binding)
	# end

end

session = OnlineJukebox.new
puts session.display_artists
puts session.display_genres
