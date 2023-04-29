class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  before_validation :ensure_jti_is_set

  has_many :short_urls

  def revoke_jwt
    update_column(:jti, generate_jti)
  end

  private

    def generate_jti
      SecureRandom.uuid
    end

    def ensure_jti_is_set
      self.jti = generate_jti
    end
end
