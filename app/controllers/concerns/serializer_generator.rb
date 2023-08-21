# frozen_string_literal: true

# module of serializer generator
module SerializerGenerator
  extend ActiveSupport::Concern

  def generate_collection_serializer(resources, serializer)
    ActiveModel::Serializer::CollectionSerializer.new(
      resources, serializer: serializer.to_s.constantize
    )
  end
end
