class Employer < ApplicationRecord
  	belongs_to :user

	validates :compName,
	presence: true

	validates :compSize,
	presence: true,
	numericality: { only_integer: true }

	validates :city,
	presence: true

	validates :compDesc,
	presence: true
end