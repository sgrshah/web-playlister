class Genre

  attr_accessor :name, :songs, :artists

  Genres = []

  def initialize
     Genres << self 
     @songs = []
     @artists = []
  end

  def self.all
    Genres
  end

  def self.reset_genres
    Genres.delete_if {|value| value || !value} 
  end

end
