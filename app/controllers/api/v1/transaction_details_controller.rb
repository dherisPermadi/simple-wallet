module Api
  module V1
    class TransactionDetailsController < ApplicationController
      before_action :doorkeeper_authorize!

      def top_transaction
        user = current_user
        transactions = TransferReport.where("(source_user_id = ? AND transfer_type = 'out' ) OR (target_user_id = ? AND transfer_type = 'in')",
                                            user.id, user.id)
                                     .order('ABS(amount) desc')
                                     .limit(10)

        render json: generate_collection_serializer(transactions, TransactionDetailSerializer)
      end

      def top_overall
        user = current_user
        transactions = TransactionReport.where('source_user_id = ?', user.id)
                                        .order(amount: :desc)
                                        .limit(10)

        render json: generate_collection_serializer(transactions, TransactionSerializer)
      end
    end
  end
end
