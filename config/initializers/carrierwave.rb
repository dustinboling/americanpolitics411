CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAI3YS3NMLE5EI6HVA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'ap411-profile-photos'                     # required
  # config.fog_host       = 'https://s3.amazonaws.com'
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
