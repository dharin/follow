require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      expect(full_title("demo")).to match(/demo/)
    end

    it "should include the base title" do
      expect(full_title("Demo application - Rails")).to match(/^Demo/)
    end

    it "should not include a bar for the home page" do
      expect(full_title("")).not_to match(/\|/)
    end
  end
end

bundle install
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rspec spec/

