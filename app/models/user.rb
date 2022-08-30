# frozen_string_literal: true

# user model
class User < ApplicationRecord
  has_one :form
  has_many :floors
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true,
                    length: { minimum: 5, maxmimum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true,
                   length: { minimum: 3 }

  validates :password, presence: true,
                       length: { minimum: 6, maximum: 20 }
end
