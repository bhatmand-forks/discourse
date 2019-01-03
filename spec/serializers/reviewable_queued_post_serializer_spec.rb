require 'rails_helper'

describe ReviewableQueuedPostSerializer do

  let(:reviewable) { Fabricate(:reviewable_queued_post) }
  let(:admin) { Fabricate(:admin) }

  it "includes the user fields for review" do
    json = ReviewableQueuedPostSerializer.new(reviewable, scope: Guardian.new(admin), root: nil).as_json
    expect(json[:raw]).to eq('hello world post contents.')
    expect(json[:title]).to eq('queued post title')
    expect(json[:topic_id]).to eq('queued post title')
  end

end
