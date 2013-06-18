
class Artist 

  attr_accessor :name, :songs, :genres

  Roster = []

  def initialize
    Roster << self
    @songs = []
    @genres = []
  end

  def self.reset_artists
    Roster.clear
  end

  def self.count
    Roster.count
  end 

  def self.all
    Roster 
  end

  def songs_count
    @songs.count
  end

  def add_song(song)
    @songs << song
    @genres << song.genre 
    song.artist = @name
    song.genre.artists << self if song.genre && !song.genre.artists.include?(self)
  end

end
