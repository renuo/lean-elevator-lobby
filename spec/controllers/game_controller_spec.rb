require 'rails_helper'

RSpec.describe GameController, type: :controller do
  login_user

  describe "GET #admin" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #start" do
    it "returns http success" do
      get :start, params: { start_with_game_config: {
          building_size: 1,
          decider_timeout: 0.1,
          round_delay: 0,
          round_limit: 0
      }}
      expect(response).to redirect_to game_index_path
    end
  end

  describe "GET #stop" do
    it "returns http success" do
      get :stop
      expect(response).to redirect_to game_index_path
    end
  end
end
