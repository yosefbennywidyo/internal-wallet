class HomeController < ApplicationController
  def index
    @transactionals = current_user.wallet.transactionals
  end
end
