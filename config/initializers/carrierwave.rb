# config/initializers/carrierwave.rb
# This file is not created by default so you might have to create it yourself.

CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => 'AKIAICGRCYYDCOJ5ICOQ',            # required
    :aws_secret_access_key  => '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',     # required
    :region                 => 'eu-west-2'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'elasticbeanstalk-us-west-2-976354659865'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end