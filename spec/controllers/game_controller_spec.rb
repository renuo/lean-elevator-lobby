require 'rails_helper'

RSpec.describe GameController, type: :controller do

  describe "GET #admin" do
    it "returns http success" do
      get :admin
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #start" do
    it "returns http success" do
      get :start
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #stop" do
    it "returns http success" do
      get :stop
      expect(response).to have_http_status(:success)
    end
  end

end
