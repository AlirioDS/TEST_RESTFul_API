require "test_helper"

class ReleaseTest < ActiveSupport::TestCase
  test "should create release with valid attributes" do
    release = Release.new(
      title: "New Album",
      release_date: Date.new(2024, 1, 15),
      release_type: "album",
      label: "Indie Records",
      catalog_number: "IND-001"
    )
    assert release.save
  end

  test "should have many artist_releases" do
    release = releases(:random_access_memories_release)
    assert_respond_to release, :artist_releases
  end

  test "should have many artists through artist_releases" do
    release = releases(:ok_computer_release)
    assert_respond_to release, :artists
    assert_includes release.artists.pluck(:name), "Radiohead"
  end

  test "should have many albums" do
    release = releases(:ok_computer_release)
    assert_respond_to release, :albums
    assert release.albums.count >= 1
  end

  test "destroying release should destroy associated artist_releases" do
    release = releases(:abbey_road_release)
    artist_release_count = release.artist_releases.count

    assert_difference "ArtistRelease.count", -artist_release_count do
      release.destroy
    end
  end

  test "destroying release should destroy associated albums" do
    release = releases(:random_access_memories_release)
    album_count = release.albums.count

    assert_difference "Album.count", -album_count do
      release.destroy
    end
  end

  test "release can have multiple artists" do
    release = Release.create!(
      title: "Collaboration Album",
      release_date: Date.today,
      release_type: "album",
      label: "Joint Records",
      catalog_number: "JR-001"
    )

    artist1 = artists(:radiohead)
    artist2 = artists(:daft_punk)

    release.artist_releases.create!(artist: artist1, role: "primary")
    release.artist_releases.create!(artist: artist2, role: "featured")

    assert_equal 2, release.artists.count
  end
end
