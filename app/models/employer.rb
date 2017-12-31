class Employer < ApplicationRecord
  	belongs_to :user
  	has_many :jobs

  	mount_uploader :logo, ImageUploader

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