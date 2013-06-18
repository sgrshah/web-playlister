class Genre
  attr_accessor :name, :songs, :artists

  All = []

  def initialize
    @artists = []
    All << self
  end

  def songs
    Song.all.select { |song| song.genre.name == self.name if song.genre}
  end

  def self.reset_genres
    All.clear
  end

  def self.all
    All
  end

end

