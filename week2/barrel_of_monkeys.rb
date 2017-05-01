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
    chainable_songs = get_chainable_songs(playlist.last, library)
    if playlist.last == ending_song
      @playlists << playlist
    else
      chainable_songs.each do |s|
        library_aux = library.dup
        library_aux.delete(s)

        playlist_aux = playlist.dup
        playlist_aux = playlist_aux << s

        create_playlist_recursive(playlist_aux, library_aux, ending_song)
      end
    end
  end

  def self.create_playlist(starting_song, ending_song, library)
    library_aux = library.dup
    library_aux.delete(starting_song)
    create_playlist_recursive([starting_song], library_aux, ending_song)
  end

  def self.get_chainable_songs(song, library)
    library.select { |s| chainable_songs?(song, s) }
  end

  def self.chainable_songs?(s_song, e_song)
    s_song.downcase[-1] == e_song.downcase[0]
  end

  def self.existing_song?(song, library)
    library.include?(song)
  end

  def self.print_playlists
    puts "\n\Playlists\n"
    puts @playlists.inspect
  end

  def self.main(starting_song, ending_song, library)
    puts "Starting Song: #{starting_song}"
    puts "Ending Song: #{ending_song}"

    if !existing_song?(starting_song, library)
      puts "#{starting_song} that not exists in our library"
    elsif !existing_song?(ending_song, library)
      puts "#{ending_song} that not exists in our library"
    else
      create_playlist(starting_song, ending_song, library)
      print_playlists
    end
    @playlists
  end
end

BarrelOfMonkeys.main(ARGV[0], ARGV[1], BarrelOfMonkeys::LIBRARY)
