class User < ApplicationRecord
	has_secure_password

	has_one :seeker

	has_one :employer

	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
	presence: true

	validates :firstName,
	presence: true

	validates :lastName,
	presence: true

	# validates :phoneNo, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Phone number invalid, must be xxx-xxx-xxxx"},
	validates :phoneNo,
	presence: true


	validates :role,
	presence: true

	validates :password,
	length: { in: 6..20 }, on: :create
end