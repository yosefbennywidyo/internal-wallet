module WalletTransaction
  class Debit < Base
    def call
      setup_params
      debit
    end

    private

    def setup_params
      @details      ||= @params[:details]
      @source       ||= Wallet.find_by_address(@details[:source])
      @sender       ||= @source.user
      @amount       ||= @details[:amount]
      @destination  ||= Wallet.find_by_address(@details[:to])
      @destination_details ||= {
        from: @source.id,
        note: @details[:note],
        amount: @details[:amount]
      }
      @receiver     ||= @destination.user
    end

    def debit
      # sample usage:
      # WalletTransaction::Debit.call(details: {source: user.wallet.address, note: 'transfer', to: team.wallet.address, amount: '10.75'})
      source_last_updated_at    = @source.updated_at
      transactional_last_length = Transactional.all.length

      if BigDecimal(@source.balance) >= BigDecimal(@amount)
        ActiveRecord::Base.transaction do
          @source.update(balance: (@source.balance - BigDecimal(@amount)))
          @destination.update!(balance: @destination.balance + BigDecimal(@amount))
          Transactional.create(type: 'Debit', date: DateTime.now, details: @details, wallet_id: @source.id)
          Transactional.create(type: 'Credit', date: DateTime.now, details: @destination_details, wallet_id: @destination.id)
        end

        source_current_updated_at = @source.reload.updated_at

        return true if source_current_updated_at > source_last_updated_at
      else
        return false
      end
    end
  end
end