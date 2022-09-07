RSpec.shared_context "shared initialization", :shared_context => :metadata do
  before(:all) do
    @user = create(:user)
    @team = create(:user, :team)
  end
end