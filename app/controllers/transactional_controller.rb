class TransactionalController < ApplicationController
before_action :set_transactional, only: %i[ show edit update destroy ]

  # GET /transactional or /transactional.json
  def index
    @transactionals = current_user.wallet.transactionals
  end

  # GET /transactional/new
  def new

    @receiver ||= Wallet.where.not(id: current_user.wallet.id).joins(:user)
    #Wallet.where.not(id: current_user.wallet.id).joins(:user).map {|wallet| @receiver << [wallet.address, wallet.user.email]}
    @transactional = current_user.wallet.transactionals.new
  end

  # POST /transactional or /transactional.json
  def create
    setup_params(params)
    puts "@params.inspect #{@params.inspect}"

    #respond_to do |format|
      if WalletTransaction::Debit.call(
          details: {source: current_user.wallet.address, note: 'transfer', to: User.find(params[:transactional][:user_id]).wallet.address, amount: params[:transactional][:amount]}
        )
        redirect_to home_index_path, notice: 'transactional was successfully created'
      else
        redirect_to home_index_path, notice: @transactional.errors.full_messages
      end
    #end
  end

  def setup_params(params)
    @params     = {}
    @params[:date] = Time.now
    @params[:details] = {
      source: current_user.wallet.address,
      note: params[:transactional][:note],
      to: User.find(params[:transactional][:user_id]).wallet.address,
      amount: params[:transactional][:amount],
    }
    @params[:wallet_id] = Wallet.find(params[:transactional][:user_id]).id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transactional
      @transactional = current_user.wallet.transactionals.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transactional_params
      params.require(:transactional).permit(:note, :to, :amount, :type, :user_id)
    end
end
