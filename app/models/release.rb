class Release < ApplicationRecord
  has_many :artist_releases, dependent: :destroy
  has_many :artists, through: :artist_releases
  has_many :albums, dependent: :destroy
end
