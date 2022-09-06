require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  include_context "shared initialization"

  describe 'index page' do
    it 'not login - able to see welcome page' do
      visit root_path
      expect(page).to have_content('Welcome to Internal Wallet')
    end
  end
end