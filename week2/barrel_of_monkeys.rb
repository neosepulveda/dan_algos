@library = [
  "Peace Train",
  "No More I Love You's",
  "Super Trooper",
  "Rock Me, Amadeus",
  "Song of the South",
  "Hooked on a Feeling",
  "Go Tell it on the Mountain",
]

@starting_song = ARGV[0]
@ending_song = ARGV[1]

def create_playlist(playlist, library)
  if library.empty?
    return playlist
  else
    get_chainable_songs(playlist.last, library).each do |s|
      library_aux = library.dup
      library_aux.delete(s)

      playlist_aux = playlist.dup
      playlist_aux = playlist_aux << s

      #puts "Library Aux: #{library_aux}"
      #puts "Playlist Aux: #{playlist_aux}"

      return create_playlist(playlist_aux, library_aux)
    end
  end
end

def get_chainable_songs(song, library)
  library.select { |s| chainable_songs?(song, s) }
end

def chainable_songs?(s_song, e_song)
  s_song.downcase[-1] == e_song.downcase[0]
end

def existing_song?(song, library)
  library.include?(song)
end


def main_algo(starting_song, ending_song, library)
  puts "Starting Song: #{starting_song}"
  puts "Ending Song: #{ending_song}"

  if !existing_song?(starting_song, library)
    puts "#{starting_song} that not exists in our library"
  elsif !existing_song?(ending_song, library)
    puts "#{ending_song} that not exists in our library"
  else
    library_aux = library.dup
    library_aux.delete(starting_song)
    puts "\n\Playlist\n"
    puts create_playlist([starting_song], library_aux).join(' > ')
  end
end

main_algo(@starting_song, @ending_song, @library)
