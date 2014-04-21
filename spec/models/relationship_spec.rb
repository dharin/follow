require 'spec_helper'

describe Relationship do

  let(:Follower) { FactoryGirl.create(:user) }
  let(:Followed) { FactoryGirl.create(:user) }
  let(:relationship) { Follower.relationships.build(Followed_id: Followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "Follower methods" do    
    it { should respond_to(:Follower) }
    it { should respond_to(:Followed) }
    its(:Follower) { should eq Follower }
    its(:Followed) { should eq Followed }
  end

  describe "when Followed id is not present" do
    before { relationship.Followed_id = nil }
    it { should_not be_valid }
  end

  describe "when Follower id is not present" do
    before { relationship.Follower_id = nil }
    it { should_not be_valid }
  end
end