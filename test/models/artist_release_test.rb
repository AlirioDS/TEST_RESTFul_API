require "test_helper"

class ArtistReleaseTest < ActiveSupport::TestCase
  test "should create artist_release with valid attributes" do
    artist = artists(:radiohead)
    release = releases(:get_lucky_single)

    artist_release = ArtistRelease.new(
      artist: artist,
      release: release,
      role: "featured"
    )
    assert artist_release.save
  end

  test "should belong to artist" do
    artist_release = artist_releases(:radiohead_ok_computer)
    assert_respond_to artist_release, :artist
    assert_not_nil artist_release.artist
  end

  test "should belong to release" do
    artist_release = artist_releases(:daft_punk_ram)
    assert_respond_to artist_release, :release
    assert_not_nil artist_release.release
  end

  test "should require artist" do
    release = releases(:ok_computer_release)
    artist_release = ArtistRelease.new(release: release, role: "primary")
    assert_not artist_release.save
  end

  test "should require release" do
    artist = artists(:beatles)
    artist_release = ArtistRelease.new(artist: artist, role: "primary")
    assert_not artist_release.save
  end

  test "should have role attribute" do
    artist_release = artist_releases(:daft_punk_get_lucky)
    assert_equal "primary", artist_release.role
  end

  test "same artist can have multiple releases" do
    artist = artists(:daft_punk)
    assert artist.releases.count >= 2
  end

  test "can update role" do
    artist_release = artist_releases(:beatles_abbey_road)
    artist_release.update!(role: "producer")
    assert_equal "producer", artist_release.reload.role
  end
end
