class User < ApplicationRecord
  before_create :generate_api_key
  has_secure_password

  validates :email, uniqueness: true, presence: true

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
