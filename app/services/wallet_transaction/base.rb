module WalletTransaction
  class Base < ApplicationService
    attr_accessor :user_id, :details, :amount
    
    def initialize(params={})
      @params       ||= params
    end
  end
end