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

	# validates :compDesc,
	# presence: true

	def self.filter(fakes)
        if fakes
          joins(:user).where.not('"email" LIKE ?', "%#{fakes}%")

        else
          all
        end
      end

     def self.search(search)
        joins(:user).where('"compName" ILIKE :search OR "firstName" ILIKE :search OR "lastName" ILIKE :search', search: "%#{search}%")
      end

end