require 'sidekiq'
require 'sidekiq/web'

if ENV['REDIS_SERVER_URL']
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_SERVER_URL'] }
  end
end

if ENV['REDIS_CLIENT_URL']
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_CLIENT_URL'] }
  end
end
