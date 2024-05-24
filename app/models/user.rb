class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Adding devise-jwt gem to the users
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :cart
  validates :name, presence: true
  VALIDATE_EMAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false },
                    presence: true, length: { maximum: 105 },
                    format: { with: VALIDATE_EMAIL_ADDRESS }

   def generate_jwt
       JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.credentials.devise_jwt_secret_key)
   end
end
