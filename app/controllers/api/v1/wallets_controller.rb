module Api
  module V1
    class WalletsController < ApplicationController
      before_action :doorkeeper_authorize!
      before_action :set_wallet, only: [:total_balance]

      def total_balance
        render json: @wallet, serializer: WalletSerializer
      end

      protected

      def set_wallet
        @wallet = User.find(current_user.id).wallet
      end
    end
  end
end
