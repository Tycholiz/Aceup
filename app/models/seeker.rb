class Seeker < ApplicationRecord

	belongs_to :user
	has_one :skill
	has_many :applications

	validates :postalCode,
	presence: true

	validates :educationLevel,
	presence: true

	validates :degree,
	presence: true

	validates :inSales,
	presence: true,
	numericality: { only_integer: true }

	validates :outSales,
	presence: true,
	numericality: { only_integer: true }



end