require 'pry'
require_relative 'xml_parser'

class BarrelOfMonkeys

  LIBRARY = [
    "Peace Train",
    "No More I Love You's",
    "Super Trooper",
    "Rock Me, Amadeus",
    "Song of the South",
    "Hooked on a Feeling",
    "Go Tell it on the Mountain",
  ]

  @playlists = []

  def self.reset_playlists
    @playlists = []
  end

  def self.create_playlist_recursive(playlist, library, ending_song)
    #puts "PLaylistAux: #{playlist.map(&:name).join(" > ")}"
    chainable_songs = get_chainable_songs(playlist.last, library)
    if playlist.last == ending_song
      @playlists << playlist
    else
      chainable_songs.each do |s|
        library_aux = library.dup
        library_aux[s.name[0].downcase].delete(s)

        playlist_aux = playlist.dup
        playlist_aux = playlist_aux << s
        create_playlist_recursive(playlist_aux, library_aux, ending_song)
      end
    end
  end

  def self.create_playlist(starting_song, ending_song, library)
    library_aux = library.dup
    s_song = library_aux[starting_song[0].downcase].find { |s| s.name == starting_song }
    e_song = library_aux[ending_song[0].downcase].find { |s| s.name == ending_song }
    library_aux[starting_song[0].downcase].delete(starting_song)
    create_playlist_recursive([s_song], library_aux, e_song)
  end

  def self.get_chainable_songs(song, library)
    library[song.name[-1]]
  end

  def self.existing_song?(song, library)
    all_songs(library).include?(song)
  end

  def self.all_songs(library)
    @all_songs ||= library.values.flatten.map(&:name)
  end

  def self.print_playlists
    puts "\n\Playlists\n"
    puts @playlists.inspect
  end

  def self.main(starting_song, ending_song, library)
    puts "Starting Song: #{starting_song}"
    puts "Ending Song: #{ending_song}"

    if !existing_song?(starting_song, library)
      puts "#{starting_song} does not exists in our library"
    elsif !existing_song?(ending_song, library)
      puts "#{ending_song} does not exists in our library"
    else
      create_playlist(starting_song, ending_song, library)
      print_playlists
    end
    @playlists
  end
end

BarrelOfMonkeys.main(ARGV[0], ARGV[1], XmlParser.to_hash(ARGV[2]))
