class HerokuService
  def initialize
    @region = 'eu'
    @api_key = ENV['HEROKU_API_KEY']
    @slave_pipeline_id = ENV['HEROKU_SLAVE_PIPELINE_ID']
    @heroku = PlatformAPI.connect_oauth(@api_key)
  end

  def create_app(app_name)
    @heroku.app.create(name: app_name, region: @region).tap do
      Rails.logger.debug "Heroku app created: #{app_name}"
      add_to_pipeline(app_name) if @slave_pipeline_id.present?
    end
  end

  def create_build(app_name, tarball_url)
    build = @heroku.build.create(app_name, source_blob: { url: tarball_url })
    Rails.logger.debug "Heroku app built: #{app_name}"
    # TODO: handle case if failing and log it to somewhere
    build['output_stream_url']
  end

  def create_log_session(app_name)
    logs = @heroku.log_session.create(app_name)
    logs['logplex_url']
  end

  private

  def add_to_pipeline(app_name)
    @heroku.pipeline_coupling.create(app: app_name, pipeline: @slave_pipeline_id, stage: 'production')
    Rails.logger.debug "Heroku app added to pipeline: #{app_name}"
  end
end
