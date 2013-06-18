class Artist
  attr_accessor :name, :songs, :genres
  All = []

  def initialize
    All << self
    @songs = []
    @genres = []
  end

  def self.count
    @@count
  end

  def self.reset_artists
    @@count = 0
  end

  def self.all
    All
  end

  def songs_count
    @number_of_songs = @songs.length
  end

  def add_song(song)
    @songs << song
    @genres << song.genre
    song.genre.artists << self
  end

end