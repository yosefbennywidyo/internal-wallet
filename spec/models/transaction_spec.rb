require 'rails_helper'

RSpec.describe Transactional, type: :model do
  context "not able create Transactional" do
    before do
      user = create(:user)
      team = create(:user, :team)
    end

    it "when team has low balance" do
      transactional = build(:transactional, :debit_to_user)

      expect(transactional).to_not be_valid
    end

    it "when team has low balance" do
      transactional = build(:transactional, :debit_to_team)

      expect(transactional).to_not be_valid
    end
  end

  context "able create Transactional" do
    before do
      @user = create(:user)
      @team = create(:user, :team)
      @transactional = create(:transactional, type: 'Credit', details: {source: 'topup', note: 'tes', to: @user.wallet.address, amount: '1000'}, wallet_id: @user.wallet.id)
      @user.wallet.update(balance: '1000')
    end

    it "when team has enough balance" do
      transactional = create(:transactional, type: 'Debit', details: {source: @user.wallet.address, note: 'transfer', to: @team.wallet.address, amount: '10.75'}, wallet_id: @user.wallet.id)

      expect(transactional).to be_valid
    end

    it "when team has enough balance" do
      transactional = build(:transactional, :debit_to_team)

      expect(transactional).to be_valid
    end
  end

  context "able read keys" do
    before do
      @user = create(:user)
      @team = create(:user, :team)
      @transactional = create(:transactional, type: 'Credit', details: {source: 'topup', note: 'tes', to: @user.wallet.address, amount: '1000'}, wallet_id: @user.wallet.id)
      @user.wallet.update(balance: '1000')
      create(:transactional, type: 'Debit', details: {source: @user.wallet.address, note: 'transfer', to: @team.wallet.address, amount: '10.75'}, wallet_id: @user.wallet.id)
    end

    it "able read 'to' attribute" do
      expect(@transactional.to).not_to be_nil
    end

    it "able to read 'note' attribute " do
      expect(@transactional.note).not_to be_nil
    end

    it "able to read 'total' attribute " do
      expect(Transactional.total(@user.wallet.id)).not_to be_nil
    end
  end
end
