module Api
  module V1
    class WalletTransactionsController < ApplicationController
      before_action :doorkeeper_authorize!
      before_action :check_target, only: :create
  
      def create
        @topup = WalletTransaction.new(
          wallet_params.merge(
            { source_user_id: current_user.id, target_user_id: @target_user.id }
          )
        )

        if @topup.save
          render json: { response: 'Transfer success' }, status: 204
        else
          render json: { response: 'Insufficient balance or destination user is not valid' }, status: 400
        end
      end

      protected

      def wallet_params
        params.fetch(:wallet_transaction, {}).permit(:to_username, :amount)
      end

      def check_target
        @target_user = User.find_by_username(params[:to_username])

        if @target_user.blank?
          render json: { response: 'Destination user not found' }, status: 404
        end
      end
    end
  end
end
