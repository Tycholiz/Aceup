class Application < ApplicationRecord
	belongs_to :seeker
	belongs_to :job

	validates :job_id,
	presence: true,
	uniqueness: { message: "You can only apply once!" }

	validates :seeker_id,
	presence: true
end

