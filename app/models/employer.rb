class Employer < ApplicationRecord
  	belongs_to :user
  	has_many :jobs

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