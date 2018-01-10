# config/initializers/carrierwave.rb
# This file is not created by default so you might have to create it yourself.
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

if Rails.env.production?
    CarrierWave.configure do |config|
    #config.storage = :fog

    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      region: ENV['S3_REGION']
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public = false
    config.storage = :fog
  end
end
