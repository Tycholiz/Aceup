class Seeker < ApplicationRecord

	belongs_to :user

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

	validates :inboundSales,
	presence: true

	validates :outboundSales,
	presence: true
end