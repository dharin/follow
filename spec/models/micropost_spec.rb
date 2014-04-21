require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @micropost = Micropost.new(content: "Test Post", user_id: user.id)
  end
  
  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
    
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @micropost.content = "a" * 160 }
    it { should_not be_valid }
  end
end
