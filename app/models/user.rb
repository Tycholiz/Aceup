class User < ApplicationRecord
	has_secure_password

	has_one :seeker, dependent: :destroy

	has_one :employer, dependent: :destroy

	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
	presence: true,
	uniqueness: true

	validates :firstName,
	presence: true

	validates :lastName,
	presence: true

	validates :phoneNo, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Phone number invalid, must be xxx-xxx-xxxx"}, if: 'phoneNo.present?'
	# validates :phoneNo,
	# presence: true


	validates :role,
	presence: true

	validates :password,
	length: { in: 6..20 }, on: :create

	validates_presence_of :password_confirmation, :if => :password_digest_changed?
end