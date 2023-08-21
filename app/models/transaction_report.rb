class TransactionReport < ApplicationRecord
  belongs_to :source_user, class_name: "User"
  belongs_to :target_user, class_name: "User"

  def username
    target_username
  end
end
