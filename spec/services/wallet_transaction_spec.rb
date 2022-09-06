require 'rails_helper'

RSpec.describe "Homes", type: :service_object do
  before(:all) do
    @user = create(:user)
    @team = create(:user, :team)
  end

  describe "WalletTransaction::Base.new" do
    it "initialize params" do
      expect(
        WalletTransaction::Base.new.inspect
      ).to include '@params={}'
    end
  end

  describe "WalletTransaction::Credit.call" do
    it "able to topup balance" do
      expect(
        WalletTransaction::Credit.call(
          details: {
            source: 'topup', note: 'tes', to: @user.wallet.address, amount: '1000'
          }
        )
      ).to eq true
    end
  end

  describe "WalletTransaction::Debit.call" do
    it "able to debit balance, wallet balance enough" do
      @transactional = create(:transactional, type: 'Credit', details: {source: 'topup', note: 'tes', to: @user.wallet.address, amount: '1000'}, wallet_id: @user.wallet.id)
      @user.wallet.update(balance: '1000')

      expect(
        WalletTransaction::Debit.call(
          details: {
            source: @user.wallet.address, note: 'tes', to: @team.wallet.address, amount: '100'
          }
        )
      ).to eq true
    end

    it "debit on low balance, wallet balance not change" do
      expect do
        WalletTransaction::Debit.call(
          details: {
            source: @user.wallet.address, note: 'tes', to: @team.wallet.address, amount: '100'
          }
        )
      end.not_to change { @user.wallet.balance }
    end

    it "debit on low balance, wallet balance not change" do
      expect(
        WalletTransaction::Debit.call(
          details: {
            source: @user.wallet.address, note: 'tes', to: @team.wallet.address, amount: '100'
          }
        )
      ).to eq false
    end
  end
end
