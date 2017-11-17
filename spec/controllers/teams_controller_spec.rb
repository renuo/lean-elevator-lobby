require 'rails_helper'

RSpec.describe TeamsController, type: :controller do

  describe "GET #join" do
    it "returns http success" do
      get :join
      expect(response).to have_http_status(:success)
    end
  end

end
