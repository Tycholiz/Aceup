class Seeker < ApplicationRecord

	belongs_to :user
	has_many :applications, dependent: :destroy
	has_many :resumes, dependent: :destroy
	has_many :saved_jobs, dependent: :destroy

	serialize :languages
	serialize :certifications

	before_validation do |model|
        model.languages.reject!(&:blank?) if model.languages
        model.certifications.reject!(&:blank?) if model.certifications
      end

	validates :postalCode, format: { with: /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/, message: "Postal code invalid, must be (X1X 1X1)", on: :create },
	presence: true

	validates :languages,
	presence: true

	validates :educationLevel,
	presence: true

	# validates :degree,
	# presence: true

	validates :inSales,
	presence: true
	# numericality: { only_integer: true }

	validates :outSales,
	presence: true
	# numericality: { only_integer: true }

	def self.filter(fakes)
        if fakes
          joins(:user).where.not('"email" LIKE ?', "%#{fakes}%")

        else
          all
        end
      end

     def self.search(search)
        joins(:user).where('email ILIKE :search OR "firstName" ILIKE :search OR "lastName" ILIKE :search', search: "%#{search}%")
      end

end