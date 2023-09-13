# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: ENV['KEY_ID'], # required unless using use_iam_profile
    aws_secret_access_key: ENV['SECRET_KEY'] , # required unless using use_iam_profile
    region: ENV['REGION'] # optional, defaults to 'us-east-1'
  }
  config.fog_directory = ENV['S3_BUCKET'] # required
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
