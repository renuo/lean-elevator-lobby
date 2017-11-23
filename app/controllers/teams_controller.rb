class TeamsController < ApplicationController
  before_action :set_team, except: [:index, :create]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  def logs
    @logs = Rails.env.production? ? read_heroku_logs : read_local_server_logs
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.users << current_user

    respond_to do |format|
      if @team.save
        setup_team(@team)
        format.html {redirect_to @team, notice: 'Team was successfully created.'}
        format.json {render :show, status: :created, location: @team}
      else
        format.html {render :new}
        format.json {render json: @team.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html {redirect_to @team, notice: 'Team was successfully updated.'}
        format.json {render :show, status: :ok, location: @team}
      else
        format.html {render :edit}
        format.json {render json: @team.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html {redirect_to teams_url, notice: 'Team was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  protected

  def set_team
    @team = Team.find(params[:id])
  end

  private

  def read_local_server_logs
    IO.readlines("#{Rails.root}/log/#{Rails.env}.log").last(100)
  end

  def read_heroku_logs()
    logs_url = HerokuService.new.create_log_session("lean-elevator-challenge-#{@team.id}")
    res = Net::HTTP.get_response(URI.parse(logs_url))
    res.body.split('\n')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :repository, :dsn)
  end

  def setup_team(team)
    service = TeamSetupService.new(team)
    service.run
    @team.dsn = service.dsn
  end
end
