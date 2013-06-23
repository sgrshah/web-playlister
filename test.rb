require_relative 'lib/artist'
require_relative 'lib/song'
require_relative 'lib/genre'
require 'pry'
require 'pp'

def test(title, &b)
  begin
    if b
      result = b.call
      if result.is_a?(Array)
        puts "fail: #{title}"
        puts "      expected #{result.first} to equal #{result.last}"
      elsif result
        puts "pass: #{title}"
      else
        puts "fail: #{title}"
      end
    else
      puts "pending: #{title}"
    end
  rescue => e
    puts "fail: #{title}"
    puts e
  end
end

def assert(statement)
  !!statement
end

def assert_equal(actual, expected)
  if expected == actual
    true
  else
    [expected, actual]
  end
end

# Part 1: Object Models

# Create a Class for song, artist, and genre. Use an individual file for each class.
# These files should be placed within a lib directory and required on the top of
# any script that utilizes them (including this test script). Once required
# all the tests within this suite should pass.

# Artist Specs
test 'Can initialize an Artist' do
  assert Artist.new
end

test 'An artist can have a name' do
  artist = Artist.new
  artist.name = "Adele"
  assert_equal artist.name, "Adele"
end

test "An artist has songs" do
  artist = Artist.new
  artist.songs = []
  assert_equal artist.songs, []
end

test 'The Artist class can reset the artists that have been created' do
  assert Artist.reset_artists
  assert_equal Artist.count, 0
end

test 'The Artist class can keep track of artists as they are created' do
  Artist.reset_artists
  artist = Artist.new
  assert Artist.all.include?(artist)
end

test 'The Artist class can count how many artists have been created' do
  assert Artist.count
end

test 'artists have songs' do
  artist = Artist.new
  songs = (1..4).collect{|i| Song.new}
  artist.songs = songs

  assert_equal artist.songs, songs
end

test 'An artist can count how many songs they have' do
  artist = Artist.new
  songs = [Song.new, Song.new]
  artist.songs = songs

  assert_equal artist.songs_count, 2
end

test 'a song can be added to an artist' do
  artist = Artist.new
  song = Song.new
  artist.add_song(song)

  assert artist.songs.include?(song)
end

test 'artists have genres' do
  artist = Artist.new
  song = Song.new

  song.genre = Genre.new.tap{|g| g.name = "rap"}
  artist.add_song(song)

  assert artist.genres.include?(song.genre)
end

# Genre Specs
test 'Can initialize a genre' do
  assert Genre.new
end

test 'A genre has a name' do
  genre = Genre.new
  genre.name = 'rap'

  assert_equal genre.name, 'rap'
end

test 'A genre has many songs' do
  Song.reset_songs
  genre = Genre.new.tap{|g| g.name = 'rap'}
  [1,2].each do
    song = Song.new
    song.genre = genre
  end
  assert_equal genre.songs.count, 2
end

test 'A genre has many artists' do
  genre = Genre.new.tap{|g| g.name = 'rap'}

  [1,2].each do
    artist = Artist.new
    song = Song.new
    song.genre = genre
    artist.add_song(song)
  end

  assert_equal genre.artists.count, 2
end

test 'A genres Artists are unique' do
  genre = Genre.new.tap{|g| g.name = 'rap'}
  artist = Artist.new

  [1,2].each do
    song = Song.new
    song.genre = genre
    artist.add_song(song)
  end

  assert_equal genre.artists.count, 1
end

# Same behavior as Artists
test 'The Genre class can keep track of all created genres' do
  Genre.reset_genres # You must implement a method like this
  genres = [1..5].collect do |i|
    Genre.new
  end

  assert_equal Genre.all, genres
end

# Extra Credit
# Complete any song test that is pending (undefined).
# The functionality described must still be present to complete the assignment
# so even if you do not complete the pending specs, they must pass in my complete
# test suite. There's no way you'd be able to accomplish the site generation
# without your song class having this functionality, so go ahead and try
# to use assert and assert_equal to write some tests.

test 'Can initialize a song' do
  assert Song.new
end


test 'A song can have a name' do
  song = Song.new
  song.name = "happy birthday"
  assert song.name

end

test 'A song can have a genre' do
  song = Song.new
  genre = Genre.new
  song.genre = genre
  assert song.genre
end

test 'A song has an artist' do
  artist = Artist.new
  artist.name = "Kanye West"
  song = Song.new
  song.name = "Bound 2"
  artist.add_song(song)
  assert_equal song.artist, artist
end

Artist.reset_artists
Genre.reset_genres
Song.reset_songs

songs = Dir.entries("data").delete_if{|str| str[0] == "."}

songs.each do |filename|
  puts "parsing #{filename}"
  artist_name = filename.split(" - ")[0]
  song_name = filename.split(" - ")[1].split("[")[0].strip
  genre_name = filename.split(" - ")[1].split(/\[|\]/)[1]

  artist = Artist.find_by_name(artist_name) || Artist.new
  artist.name = artist_name
  
  song = Song.new
  song.name = song_name
  
  genre = Genre.find_by_name(genre_name) || Genre.new
  genre.name = genre_name

  song.genre = genre
  artist.add_song(song)

end

loop do
  puts "Name an artist?"
  choice = gets.chomp
  p Artist.all.select{|artist| artist.name == choice }[0].songs.collect{|song| song.name}
end

# binding.pry

# Part 2: Site Generation Using ERB
# write a ruby script that parses the data within the data directory
# and uses the classes defined above to instantiate Song, Artist, and Genres
# for each file. These instances should be correctly associated to each other
# so that artist.genre will return a Genre object, etc.
Artist.reset_artists
Genre.reset_genres
Song.rest_songs

  files = Dir.entries("data")
  files.shift
  files.shift

  def parse

    files.each do |song_file|

      artist = song_file.split(" - ")[0].split("/")
      song = song_file.split(" - ")[1].split("[").first.strip
      genre = song_file.split(" - ")[1].split("[").last.split("]").first.strip

      new_artist = Artist.find_by_name(artist) || Artist.new
      new_artist.name = artist

      new_song = Song.new
      new_song.name = song

      new_genre = Genre.find_by_name(genre) || Genre.new
      new_genre.name = genre

      new_artist.add_song(new_song)

    end
  end

  # puts Artist.all.collect {|a| a.name}
  # puts Genre.all.collect {|a| a.genre}


# This script should additionally Generate a website that has the following sections:
# An index page that links to the two sections of the sites, artists and genres

  # site/index.html
    # links to artists.html
    # links to genres.html

  # This index page does not need to be generated by the application, you can just manually
  # create it.

# Templates should be generated via ERB files located in lib/views.

# site/artists.html
# The artist index must list all the artists. This list must be sorted alphabetically.
# In addition to the Artists name, the artists total song count should be displayed.
# The artist name should link to the artists individual page within site/artists.
# This page should also say how many Artists there are in total.

# artists/<artist>.html
# The script must generate an artist page for each individual artist that was created
# during import. An artists page should list the name of the artist along with their songs
# and genres. The songs and genres must link to the individual song and genre page.

  # M83 - 8 Songs
  #   1. Midnight City - Folk
  #   2. Kim & Jesse - Pop

# genres.html
# The genre index must list all the genres. This list must be sorted by the amount of songs.
# In addition to the Genres name, the total song and artist count should be listed along side it.
# The genre name should linke to the genres individual page within site/genres.

  # Folk: 8 Songs, 3 Artists

# genres/<genre>.html
# The script must generate a genre page for each individual genre that was created
# during import. A genres page should list the name of the songs, linking to the individual
# song and artists. Also include the total unique artists and song counts in the genre.

# Folk
  # M83 - Midnight City
  # Lady Gaga - Pokerface

# songs/<song>.html
# The song page should list all the available information on the song, it's artist and genre
# with the appropriate links.

# Extra Credit:
# Use a ruby module somewhere to refactor common functionality.
