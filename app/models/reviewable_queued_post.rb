require_dependency 'reviewable'

class ReviewableQueuedPost < Reviewable
end

# == Schema Information
#
# Table name: reviewables
#
#  id                      :bigint(8)        not null, primary key
#  type                    :string           not null
#  status                  :integer          default(0), not null
#  created_by_id           :integer          not null
#  reviewable_by_moderator :boolean          default(FALSE), not null
#  reviewable_by_group_id  :integer
#  claimed_by_id           :integer
#  category_id             :integer
#  target_id               :integer
#  target_type             :string
#  payload                 :json
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  topic_id                :integer
#
# Indexes
#
#  index_reviewables_on_status              (status)
#  index_reviewables_on_status_and_type     (status,type)
#  index_reviewables_on_type_and_target_id  (type,target_id) UNIQUE
#
