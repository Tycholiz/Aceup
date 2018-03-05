class User < ApplicationRecord
	has_secure_password

	has_one :seeker, dependent: :destroy

	has_one :employer, dependent: :destroy

	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
	# presence: true,
	allow_blank: true,
	uniqueness: true
	# unless: :temp

	# Only allow letter, number, underscore and punctuation.
	validates :username, 
	# format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }, 
	presence: true, unless: :temp,
	uniqueness: true, unless: :temp

	# validates :firstName,
	# presence: true, unless: :temp

	# validates :lastName,
	# presence: true, unless: :temp

	validates :phoneNo, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Phone number invalid, must be xxx-xxx-xxxx"}, if: 'phoneNo.present?'
	# validates :phoneNo,
	# presence: true


	# validates :role,
	# presence: true

	validates :password, length: { in: 6..20 }, on: :create

	validates_presence_of :password_confirmation, :if => :password_digest_changed?

	validate :validate_username
	validate :password_match

	def self.filter(fakes)
        if fakes
          where.not('"email" LIKE ?', "%#{fakes}%")
        else
          all
        end
      end

     def self.search(search)
        where('email ILIKE :search OR "firstName" ILIKE :search OR "lastName" ILIKE :search', search: "%#{search}%")
      end

     validate :validate_username

	def validate_username
	unless temp
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	 end
	end

	def password_match
			# if errors.on(:password_confirmation)
			# unless password_confirmation.valid?
			# 	errors.add(:password, :invalid)
			# end

	if password != password_confirmation
      errors.add(:password, "Passwords don't match")
    end
			

	end
end