require 'rails_helper'

describe ReviewableSerializer do

  let(:reviewable) { Fabricate(:reviewable) }
  let(:admin) { Fabricate(:admin) }

  it "serializes all the fields" do
    json = ReviewableSerializer.new(reviewable, scope: Guardian.new(admin), root: nil).as_json

    expect(json[:id]).to eq(reviewable.id)
    expect(json[:status]).to eq(reviewable.status)
    expect(json[:type]).to eq(reviewable.type)
    expect(json[:created_at]).to eq(reviewable.created_at)
  end

  it "works without a target" do
    json = ReviewableSerializer.new(Reviewable.new, scope: Guardian.new(admin)).as_json
  end

end
