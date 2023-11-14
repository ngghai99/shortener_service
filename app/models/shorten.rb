class Shorten < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :shortened_url, presence: true, uniqueness: true
  validate :valid_url_format

  private

  def valid_url_format
    return if original_url.blank?

    unless original_url.start_with?('http://') || original_url.start_with?('https://')
      errors.add(:original_url, 'Must start with http:// or https://')
    end
  end
end
