class ShortUrl < ApplicationRecord
  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :short_code, presence: true, uniqueness: true

  before_validation :generate_short_code, on: :create

  belongs_to :user

  private

  def generate_short_code
    loop do
      self.short_code = SecureRandom.urlsafe_base64(4)
      break unless ShortUrl.exists?(short_code: short_code)
    end
  end
end
