require 'rails_helper'

RSpec.describe "Transactionals", type: :request do
  include_context "shared initialization"

  describe "GET /index" do
    it "returns http success" do
      sign_in(@user)
      get "/transactionals/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in(@user)
      get "/user/transactionals/index"
      expect(response).to have_http_status(:success)
    end
  end
end
