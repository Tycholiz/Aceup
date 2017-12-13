class User < ApplicationRecord
	has_secure_password

	validates :email,
	presence: true

	validates :firstName,
	presence: true

	validates :lastName,
	presence: true

	validates :phoneNo,
	presence: true

	validates :postalCode,
	presence: true

	validates :inSales,
	presence: true

	validates :outSales,
	presence: true

	validates :inboundSales,
	presence: true

	validates :outboundSales,
	presence: true

	validates :password,
	length: { in: 6..20 }, on: :create
end