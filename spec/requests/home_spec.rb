require 'rails_helper'

RSpec.describe "Homes", type: :request do
  include_context "shared initialization"

  describe "GET /index" do
    it "user not login returns 302" do
      get "/home/index"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      sign_in(@user)
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
