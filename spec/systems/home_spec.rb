require 'rails_helper'

RSpec.describe 'Home', type: :system do
  include_context "shared initialization"

  describe 'index page' do
    it 'not login - shows login page' do
      visit home_index_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'login - shows the right content' do
      sign_in(@user)
      visit home_index_path
      expect(page).to have_content('Transactions')
    end
  end
end