require 'rails_helper'

RSpec.describe User, type: :model do
  context "not valid create User" do
    it "without an email" do
      user = build(:user, email: "")

      expect(user).to_not be_valid
    end

    it "password and password confirmation are not equal" do
      user = build(:user, password: 'password', password_confirmation: 'pasword')

      expect(user).to_not be_valid
    end
  end

  context "valid create User" do
    it "create valid user" do
      user = build(:user)

      expect(user).to be_valid
    end
  end

  context "not valid create Team" do
    it "without an email" do
      team = build(:user, :team, email: "")

      expect(team).to_not be_valid
    end

    it "password and password confirmation are not equal" do
      team = build(:user, password: 'password', password_confirmation: 'pasword')

      expect(team).to_not be_valid
    end
  end

  context "valid create Team" do
    it "create valid user" do
      team = build(:user, :team)

      expect(team).to be_valid
    end
  end

  context "query User" do
    it "able to get User only" do
      create(:user)

      expect(User.only.length).to eq 1
    end

    it "able to get Team only" do
      create(:user, :team)

      expect(User.team.length).to eq 1
    end
  end
end
