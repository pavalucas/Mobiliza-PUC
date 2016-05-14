OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '480698852123692', '1d0d4e13ba522f747d2f60673c7a5559'
end