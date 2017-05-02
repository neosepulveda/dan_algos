require 'pry'
require_relative 'xml_parser'

class BarrelOfMonkeys

  LIBRARY = {
    "p" => [ OpenStruct.new(id: 1, name: "Peace Train", artist: "Artist1", duration: 12000) ],
    "n" => [ OpenStruct.new(id: 2, name: "No More I Love You's", artist: "Artist2", duration: 12000) ],
    "s" => [
              OpenStruct.new(id: 3, name: "Super Trooper", artist: "Artist3", duration: 12000),
              OpenStruct.new(id: 5, name: "Song Of The South", artist: "Artist5", duration: 12000)
           ],
    "r" => [ OpenStruct.new(id: 4, name: "Rock Me, Amadeus", artist: "Artist4", duration: 12000) ],
    "h" => [ OpenStruct.new(id: 6, name: "Hooked On A Feeling", artist: "Artist6", duration: 12000) ],
    "g" => [ OpenStruct.new(id: 7, name: "Go Tell It On The Mountain", artist: "Artist7", duration: 12000) ],
  }

  @playlists = []

  def self.reset_playlists
    @playlists = []
  end

  def self.create_playlist_recursive(playlist, library, ending_song)
    chainable_songs = get_chainable_songs(playlist.last, library)
    if playlist.last == ending_song
      puts "Match found."
      @playlists << playlist
    else
      chainable_songs.each do |s|
        library_aux = Marshal.load(Marshal.dump(library))
        library_aux[s.name[0].downcase].delete(s)

        playlist_aux = Marshal.load(Marshal.dump(playlist))
        playlist_aux = playlist_aux << s
        create_playlist_recursive(playlist_aux, library_aux, ending_song)
      end
    end
  end

  def self.create_playlist(starting_song, ending_song, library)
    library_aux = Marshal.load(Marshal.dump(library))
    s_song = library_aux[starting_song[0].downcase].find { |s| s.name == starting_song }
    e_song = library_aux[ending_song[0].downcase].find { |s| s.name == ending_song }
    library_aux[starting_song[0].downcase].delete(s_song)
    create_playlist_recursive([s_song], library_aux, e_song)
  end

  def self.get_chainable_songs(song, library)
    library[song.name[-1]] || []
  end

  def self.existing_song?(song, library)
    all_songs(library).include?(song)
  end

  def self.all_songs(library)
    @all_songs ||= library.values.flatten.map(&:name)
  end

  def self.print_playlists
    puts "\n\Playlists\n"
    @playlists.each_with_index { |playlist, i| print_playlist(playlist, i) }
  end

  def self.print_playlist(playlist, i)
    puts "Playlist ##{i}: #{playlist.map(&:name).join(" > ")}\n\n"
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
