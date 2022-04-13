class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  has_associated_audits

  def jwt_payload
    self.refresh_token = loop do
      random_key = SecureRandom.uuid
      break random_key unless User.exists?(refresh_token: random_key)
    end
    self.save
    { 'refresh_token' => refresh_token }
  end
end
