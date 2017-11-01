class TeamSetupService
  attr_reader :dsn

  def initialize(team)
    @team = team
  end

  def run
    create_heroku_app
    assign_dsn_to_team
  end


  # { "acm" => false,
  #   "archived_at" => nil,
  #   "buildpack_provided_description" => nil,
  #   "build_stack" => { "id" => "ee582d3c-717d-4a57-ba5f-8b3a39f3a817", "name" => "heroku-16" },
  #   "created_at" => "2017-11-01T13:41:08Z",
  #   "id" => "ff92b1b0-4138-4782-9664-b19e5d01df47",
  #   "git_url" => "https://git.heroku.com/lean-elevator-challenge-1.git",
  #   "maintenance" => false,
  #   "name" => "lean-elevator-challenge-1",
  #   "owner" => { "email" => "simon.huber@renuo.ch",
  #                "id" => "80589b0d-7704-4e2a-ae19-a0ccb7013d20" },
  #   "region" => { "id" => "59accabd-516d-4f0e-83e6-6e3757701145", "name" => "us" },
  #   "organization" => nil,
  #   "team" => nil,
  #   "space" => nil,
  #   "released_at" => "2017-11-01T13:41:08Z",
  #   "repo_size" => nil,
  #   "slug_size" => nil,
  #   "stack" => { "id" => "ee582d3c-717d-4a57-ba5f-8b3a39f3a817", "name" => "heroku-16" },
  #   "updated_at" => "2017-11-01T13:41:08Z",
  #   "web_url" => "https://lean-elevator-challenge-1.herokuapp.com/" }
  private
  def create_heroku_app
    heroku = PlatformAPI.connect_oauth(ENV['HEROKU_AUTH'])
    app = heroku.app.create({name: "lean-elevator-challenge-#{@team.id}" })
    @dsn = app[:web_url]
    # => {"id"=>22979756,
    #     "name"=>"floating-retreat-4255",
    #     "dynos"=>0,
    #     "workers"=>0,
    #     "repo_size"=>nil,
    #     "slug_size"=>nil,
    #     "stack"=>"cedar",
    #     "requested_stack"=>nil,
    #     "create_status"=>"complete",
    #     "repo_migrate_status"=>"complete",
    #     "owner_delinquent"=>false,
    #     "owner_email"=>"jkakar@heroku.com",
    #     "owner_name"=>nil,
    #     "domain_name"=>
    #       {"id"=>nil,
    #        "app_id"=>22979756,
    #        "domain"=>"floating-retreat-4255.herokuapp.com",
    #        "base_domain"=>"herokuapp.com",
    #        "created_at"=>nil,
    #        "default"=>true,
    #        "updated_at"=>nil},
    #     "web_url"=>"http://floating-retreat-4255.herokuapp.com/",
    #     "git_url"=>"git@heroku.com:floating-retreat-4255.git",
    #     "buildpack_provided_description"=>nil,
    #     "region"=>"us",
    #     "created_at"=>"2014/03/12 16:44:09 -0700",
    #     "archived_at"=>nil,
    #     "released_at"=>"2014/03/12 16:44:10 -0700",
    #     "updated_at"=>"2014/03/12 16:44:10 -0700"}

    #  @dsn = app[:name]
    # @dsn = 'floating-retreat-4255'
  end


  def assign_dsn_to_team
    @team.update!(dsn: @dsn)
  end
end
