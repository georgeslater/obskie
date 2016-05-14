#require 'redis'

#REDIS = Redis.connect(url: ENV['REDISTOGO_URL'])

Geocoder.configure(
 timeout: 10,
 ip_lookup: :google,
 #cache: REDIS,
 always_raise: [
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::InvalidRequest,
    Geocoder::InvalidApiKey
  ]  
)