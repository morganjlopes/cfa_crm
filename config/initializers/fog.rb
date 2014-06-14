CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => Rails.configuration.aws_access_key_id,       # required
    :aws_secret_access_key  => Rails.configuration.aws_secret_access_key    # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 'static-assets.lgwstaging.com',             # optional, defaults to nil
    # :endpoint               => 'static-assets.lgwstaging.com.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = Rails.configuration.bucket_name             # required
  # config.fog_public     = false                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
