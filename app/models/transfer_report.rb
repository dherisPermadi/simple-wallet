class TransferReport < ApplicationRecord
  extend Enumerize

  belongs_to :source_user, class_name: "User"
  belongs_to :target_user, class_name: "User"

  enumerize :transfer_type, in: %i[out in], default: :out, scope: :shallow

  def username
    transfer_type.eql?('in') ? source_username : target_username
  end
end
