require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  test "should create album with valid attributes" do
    release = releases(:get_lucky_single)
    album = Album.new(
      title: "Get Lucky EP",
      release_date: Date.new(2013, 4, 19),
      genre: "Electronic",
      total_tracks: 4,
      duration_seconds: 1200,
      release: release
    )
    assert album.save
  end

  test "should belong to release" do
    album = albums(:ok_computer)
    assert_respond_to album, :release
    assert_not_nil album.release
  end

  test "should require release" do
    album = Album.new(
      title: "Orphan Album",
      release_date: Date.today,
      genre: "Rock",
      total_tracks: 10,
      duration_seconds: 3000
    )
    assert_not album.save
  end

  test "should access release attributes" do
    album = albums(:random_access_memories)
    assert_equal "Random Access Memories", album.release.title
    assert_equal "Columbia", album.release.label
  end

  test "should access artists through release" do
    album = albums(:abbey_road)
    artists = album.release.artists
    assert_includes artists.pluck(:name), "The Beatles"
  end

  test "album can have genre and track info" do
    album = albums(:ok_computer)
    assert_equal "Alternative Rock", album.genre
    assert_equal 12, album.total_tracks
    assert album.duration_seconds > 0
  end
end
