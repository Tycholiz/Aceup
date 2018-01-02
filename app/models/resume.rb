class Resume < ApplicationRecord
  belongs_to :seeker

  mount_uploader :file, ResumeUploader

  # validates :file,
  # presence: true

  validates :title,
   presence: true
end
