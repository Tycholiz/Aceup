class User < ApplicationRecord
	has_secure_password

	has_one :seeker, optional: true

	validates :email,
	presence: true

	validates :firstName,
	presence: true

	validates :lastName,
	presence: true

	validates :phoneNo,
	presence: true

	validate :role,
	presence: true

	validates :password,
	length: { in: 6..20 }, on: :create
end