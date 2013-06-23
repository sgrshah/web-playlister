
class Artist
  attr_accessor :name, :songs, :genres
  All = []

  def initialize
    All << self
    @songs = []
    @genres = []
  end

  def self.count
    # @@count
    All.count
  end

  def self.reset_artists
    # @@count = 0
    All.clear
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
    song.genre.artists << self if song.genre && !song.genre.artists.include?(self)
    song.artist = self
  end

  def self.find_by_name(name)
    All.each do |artist|
      if artist.name == name
        return artist
      end
    end
    return false
  end

end
