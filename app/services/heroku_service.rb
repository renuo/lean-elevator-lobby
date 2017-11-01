# frozen_string_literal: true

class HerokuService
  def initialize
    @heroku = PlatformAPI.connect_oauth(ENV['HEROKU_AUTH'])
  end

  def create_app(name)
    heroku.app.create(name: name)
  end

  def create_build(name, tarball_url)
    build = heroku.build.create(name, { source_blob: { url: tarball_url } })
    # TODO: handle case if failing and log it to somewhere
    build[:output_stream_url]
  end
end
