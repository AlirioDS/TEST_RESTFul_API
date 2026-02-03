require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  test "should create artist with valid attributes" do
    artist = Artist.new(
      name: "New Artist",
      bio: "A new upcoming artist",
      country: "USA",
      formed_year: 2020
    )
    assert artist.save
  end

  test "should have many artist_releases" do
    artist = artists(:daft_punk)
    assert_respond_to artist, :artist_releases
    assert artist.artist_releases.count >= 1
  end

  test "should have many releases through artist_releases" do
    artist = artists(:daft_punk)
    assert_respond_to artist, :releases
    assert artist.releases.count >= 1
  end

  test "should access release titles through association" do
    artist = artists(:radiohead)
    assert_includes artist.releases.pluck(:title), "OK Computer"
  end

  test "destroying artist should destroy associated artist_releases" do
    artist = artists(:beatles)
    artist_release_count = artist.artist_releases.count

    assert_difference "ArtistRelease.count", -artist_release_count do
      artist.destroy
    end
  end

  test "should allow artist without releases" do
    artist = Artist.create!(
      name: "Solo Artist",
      bio: "Just starting out",
      country: "Canada",
      formed_year: 2023
    )
    assert_equal 0, artist.releases.count
  end
end
