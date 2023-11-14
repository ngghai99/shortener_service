class Shorten < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true
  validates :shortened_url, presence: true, uniqueness: true
end
