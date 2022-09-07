require 'rails_helper'

RSpec.describe "/home/index", type: :view do
  include_context "shared initialization"

  before do
    sign_in(@user)
  end

  it "user not login redirect to " do
    visit 'home/index'
    puts "current_path.inspect #{current_path.inspect}"
    expect(current_path).to eq(new_user_session_path)
  end
end
