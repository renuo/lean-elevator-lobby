# frozen_string_literal: true
uri = ENV['REDIS_URL'].present? ? ENV['REDIS_URL'] : 'redis://localhost:6379/'
REDIS = Redis.new(url: uri)
