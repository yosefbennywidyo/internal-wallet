require 'rails_helper'

RSpec.describe "/transactional/index", type: :view do
  include_context "shared initialization"

  it "user not login redirect to " do
    visit 'transactional/index'

    puts "current_path.inspect #{current_path.inspect}"
    expect(current_path).to eq('/transactional/index')
  end
end
