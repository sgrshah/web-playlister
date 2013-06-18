class Genre
  attr_accessor :name, :songs, :artists

  def initialize
    @artists = []
  end

  def songs
    Song.all.select { |song| song.genre.name == self.name if song.genre}
  end

end

