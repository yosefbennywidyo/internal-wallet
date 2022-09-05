class User < ApplicationRecord
  has_one :wallet, dependent: :destroy
  after_create :setup_wallet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def setup_wallet
    Wallet.create(address: SecureRandom.uuid, user_id: self.id, balance: 0)
  end

  def self.only
    where(type: 'User')
  end

  def self.team
    where(type: 'Team')
  end
end
