class Song
  
  attr_accessor :genre
  All = []

  def initialize
    All << self
  end

  def self.all
    All
  end

  def self.reset_songs
    All.clear
  end

end