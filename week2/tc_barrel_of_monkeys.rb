require 'test/unit'
require_relative 'barrel_of_monkeys'

class BarrelOfMonkeysTest < Test::Unit::TestCase
  def test0
    assert_equal(1,1)
  end

  def test1
    output = [
      [
        "Peace Train",
        "No More I Love You's",
        "Super Trooper",
        "Rock Me, Amadeus",
        "Song of the South",
        "Hooked on a Feeling",
        "Go Tell it on the Mountain"
      ],
      [
        "Peace Train",
        "No More I Love You's",
        "Song of the South",
        "Hooked on a Feeling",
        "Go Tell it on the Mountain"
      ]
    ]

    assert_equal(main_helper("Peace Train", "Go Tell it on the Mountain"), output);
  end

  def test2
    output = [
      [
        "Super Trooper",
        "Rock Me, Amadeus",
        "Song of the South",
        "Hooked on a Feeling",
        "Go Tell it on the Mountain"
      ]
    ]

    assert_equal(main_helper("Super Trooper", "Go Tell it on the Mountain"), output);
  end

  def test3
    output = [
      [
        "Rock Me, Amadeus",
        "Song of the South",
        "Hooked on a Feeling",
        "Go Tell it on the Mountain"
      ]
    ]

    assert_equal(main_helper("Rock Me, Amadeus", "Go Tell it on the Mountain"), output);
  end

  def test4
    assert_equal(main_helper("foo", "bar"), [])
  end

  def test5
    assert_equal(main_helper("Song of the South", "foo"), [])
  end

  def test6
    assert_equal(main_helper("Hooked on a Feeling", "foo"), [])
  end

  private

  def main_helper(song_start, song_end)
    r = BarrelOfMonkeys.main(song_start, song_end, BarrelOfMonkeys::LIBRARY)
    BarrelOfMonkeys.reset_playlists
    r
  end
end
