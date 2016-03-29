OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  #provider :facebook, '209285722769760', '9e32db68200a6d1417fade42cb26e58a'
end