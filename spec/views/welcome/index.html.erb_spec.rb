require 'rails_helper'

RSpec.describe "welcome/index.html.tailwindcss", type: :view do
  it "user not login redirect to " do
    visit '/'
    
    expect(current_path).to eq(root_path)
  end
end
