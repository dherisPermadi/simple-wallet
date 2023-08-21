module Api
  module V1
    class TransactionDetailsController < ApplicationController
      before_action :doorkeeper_authorize!

      def top_transactions
        user = current_user
        transactions = TransferReport.where("(source_user_id = ? AND transfer_type = 'out' ) OR (target_user_id = ? AND transfer_type = 'in')",
                                            user.id, user.id)
                                     .order('ABS(amount) desc')
                                     .limit(10)

        render json: generate_collection_serializer(transactions, TransactionDetailSerializer)
      end

      def top_users
        transactions = TransactionReport.order(amount: :desc).limit(10)

        render json: generate_collection_serializer(transactions, TransactionSerializer)
      end
    end
  end
end
