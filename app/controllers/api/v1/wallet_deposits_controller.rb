module Api
  module V1
    class WalletDepositsController < ApplicationController
      before_action :doorkeeper_authorize!
      before_action :set_wallet, only: [:create]
  
      def create
        @topup = WalletDeposit.new(wallet_params.merge({ wallet_id: @wallet.id }))

        if @topup.save
          render json: { response: 'Topup successful' }, status: 204
        else
          render json: { response: 'Invalid topup amount' }, status: 400
        end
      end

      protected

      def set_wallet
        @wallet = User.find(current_user.id).wallet
      end

      def wallet_params
        params.fetch(:wallet_deposit, {}).permit(:amount)
      end
    end
  end
end
