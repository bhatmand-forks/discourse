require_dependency 'reviewable_action_serializer'

class ReviewableSerializer < ApplicationSerializer
  attributes(
    :id,
    :status,
    :type,
    :created_at,
    :topic_id
  )

  has_many :reviewable_actions, serializer: ReviewableActionSerializer

  def reviewable_actions
    object.actions_for(scope).to_a
  end

  def self.create_attribute(name, field)
    attribute(name)

    class_eval <<~GETTER
      def #{name}
        #{field}
      end

      def include_#{name}?
        #{name}.present?
      end
    GETTER
  end

  # This is easier than creating an AMS method for each attribute
  def self.target_attributes(*attributes)
    attributes.each do |a|
      create_attribute(a, "object.target.#{a}")
    end
  end

  def self.payload_attributes(*attributes)
    attributes.each do |a|
      create_attribute(a, "object.payload['#{a}']")
    end
  end

  def attributes
    data = super

    if object.target.present?
      # Automatically add the target id as a "good name" for example a target_type of `User`
      # becomes `user_id`
      data[:"#{object.target_type.downcase}_id"] = object.target_id
    end

    data
  end

  def include_topic_id?
    object.topic_id.present?
  end

end
