require 'rails_helper'

RSpec.describe 'Transactional', type: :system do
  include_context "shared initialization"

  describe 'index page' do
    before do
      sign_in(@user)
    end

    it 'login - able to see transactional page' do
      visit user_transactional_index_path
      expect(page).to have_content('Welcome to Internal Wallet')
    end

    it 'login - able to see transactional page' do
      visit new_user_transactional_path
      expect(page).to have_content('New transactions')
    end
  end
end