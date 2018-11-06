require 'rails_helper'

RSpec.describe WikiPage, type: :model do
  describe "current_revision" do
    before do
      @user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
      @wiki_page = WikiPage.create(locked: false)
      @wiki_page.revisions.new(title: "Hello1", content: "world1", user: @user).save!
      @wiki_page.revisions.new(title: "Hello2", content: "world2", user: @user).save!
      @wiki_page.revisions.new(title: "Hello3", content: "world3", user: @user).save!
      @wiki_page.save
    end
    it "returns the correct revision" do
      revision = @wiki_page.current_revision
      expect(revision.title).to eq("Hello3")
      expect(revision.content).to eq("world3")
    end
    after do
      @wiki_page.destroy
      @user.destroy
    end
  end
end
