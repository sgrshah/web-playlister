class Song
  
  attr_accessor :genre, :name, :artist
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

  def self.find_by_name(name)
    All.each do |song|
      if song.name == name
        return song
      end
    end
    return false
  end

end

