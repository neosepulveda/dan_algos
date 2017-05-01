require 'test/unit'
require_relative 'barrel_of_monkeys'

class BarrelOfMonkeysTest < Test::Unit::TestCase
  def test0
    assert_equal(1,1)
  end

  def test1
    output = [
      [
        OpenStruct.new(id: 1, name: "Peace Train", artist: "Artist1", duration: 12000),
        OpenStruct.new(id: 2, name: "No More I Love You's", artist: "Artist2", duration: 12000),
        OpenStruct.new(id: 3, name: "Super Trooper", artist: "Artist3", duration: 12000),
        OpenStruct.new(id: 4, name: "Rock Me, Amadeus", artist: "Artist4", duration: 12000),
        OpenStruct.new(id: 5, name: "Song Of The South", artist: "Artist5", duration: 12000),
        OpenStruct.new(id: 6, name: "Hooked On A Feeling", artist: "Artist6", duration: 12000),
        OpenStruct.new(id: 7, name: "Go Tell It On The Mountain", artist: "Artist7", duration: 12000),
      ],
      [
        OpenStruct.new(id: 1, name: "Peace Train", artist: "Artist1", duration: 12000),
        OpenStruct.new(id: 2, name: "No More I Love You's", artist: "Artist2", duration: 12000),
        OpenStruct.new(id: 5, name: "Song Of The South", artist: "Artist5", duration: 12000),
        OpenStruct.new(id: 6, name: "Hooked On A Feeling", artist: "Artist6", duration: 12000),
        OpenStruct.new(id: 7, name: "Go Tell It On The Mountain", artist: "Artist7", duration: 12000),
      ]
    ]

    assert_equal(main_helper("Peace Train", "Go Tell It On The Mountain"), output);
  end

  def test2
    output = [
      [
        OpenStruct.new(id: 3, name: "Super Trooper", artist: "Artist3", duration: 12000),
        OpenStruct.new(id: 4, name: "Rock Me, Amadeus", artist: "Artist4", duration: 12000),
        OpenStruct.new(id: 5, name: "Song Of The South", artist: "Artist5", duration: 12000),
        OpenStruct.new(id: 6, name: "Hooked On A Feeling", artist: "Artist6", duration: 12000),
        OpenStruct.new(id: 7, name: "Go Tell It On The Mountain", artist: "Artist7", duration: 12000),
      ]
    ]

    assert_equal(main_helper("Super Trooper", "Go Tell It On The Mountain"), output);
  end

  def test3
    output = [
      [
        OpenStruct.new(id: 4, name: "Rock Me, Amadeus", artist: "Artist4", duration: 12000),
        OpenStruct.new(id: 5, name: "Song Of The South", artist: "Artist5", duration: 12000),
        OpenStruct.new(id: 6, name: "Hooked On A Feeling", artist: "Artist6", duration: 12000),
        OpenStruct.new(id: 7, name: "Go Tell It On The Mountain", artist: "Artist7", duration: 12000),
      ]
    ]

    assert_equal(main_helper("Rock Me, Amadeus", "Go Tell It On The Mountain"), output);
  end

  def test4
    assert_equal(main_helper("foo", "bar"), [])
  end

  def test5
    assert_equal(main_helper("Song Of The South", "foo"), [])
  end

  def test6
    assert_equal(main_helper("Hooked On A Feeling", "foo"), [])
  end

  private

  def main_helper(song_start, song_end)
    r = BarrelOfMonkeys.main(song_start, song_end, BarrelOfMonkeys::LIBRARY)
    BarrelOfMonkeys.reset_playlists
    r
  end
end
