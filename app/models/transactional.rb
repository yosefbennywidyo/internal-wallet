class Transactional < ApplicationRecord
  belongs_to :wallet
  validate :check_balance

  store_accessor :to, :note, :amount, :source

  def check_balance
    
    if self.type == 'Debit'
      if BigDecimal(Wallet.find_by_address(self.source).balance) < BigDecimal(self.amount)
        errors.add(:amount, "of your wallet balance is not sufficient")
      end
    end
  end

  def to
    self.details['to'] if self.details.present?
  end

  def note
    self.details['note'] if self.details.present?
  end

  def source
    self.details['source'] if self.details.present?
  end

  def amount
    BigDecimal(self.details['amount']) if self.details.present?
  end

  def self.total(wallet_id)
    result = 0
    total_transaction ||= where(wallet_id: wallet_id)
    total_transaction.map do |transaction|
      if transaction.type == 'Debit'
        result += -transaction.amount
      else
        result += transaction.amount
      end
    end
    result.to_f
  end
end
