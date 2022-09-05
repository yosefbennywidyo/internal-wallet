module WalletTransaction
  class Credit < Base
    def call
      setup_params
      credit
    end

    private

    def setup_params
      @details      ||= @params[:details]
      @destination  ||= Wallet.find_by_address(@details[:to])
      @destination_details ||= {
        from: @details[:source],
        to: @details[:to],
        note: @details[:note],
        amount: @details[:amount]
      }
    end

    def credit
      # sample usage:
      # WalletTransaction::Credit.call(details: {source: 'topup', note: 'tes', to: user.wallet.address, amount: '1000'})
      last_updated_at = @destination.updated_at

      Transactional.transaction do
        Transactional.create(type: 'Credit', date: DateTime.now, details: @destination_details, wallet_id: @destination.id)
        @destination.update(balance: (BigDecimal(@destination.balance) + BigDecimal(@details[:amount])))
      end

      current_updated_at = @destination.reload.updated_at

      return true if current_updated_at > last_updated_at
    end
  end
end