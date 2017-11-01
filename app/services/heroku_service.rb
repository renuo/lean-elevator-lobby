class HerokuService
  def initialize
    @heroku = PlatformAPI.connect_oauth(ENV['HEROKU_AUTH'])
  end

  def create_app(name)
    @heroku.app.create(name: name)
  end

  def create_build(app_name, tarball_url)
    build = @heroku.build.create(app_name, { source_blob: { url: tarball_url } })
    # TODO: handle case if failing and log it to somewhere
    build['output_stream_url']
  end

  def create_log_session(app_name)
    logs = @heroku.log_session.create(app_name)
    logs['logplex_url']
  end
end
