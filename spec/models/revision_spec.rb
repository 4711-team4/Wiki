require 'rails_helper'

RSpec.describe Revision, type: :model do
  describe "revisions" do
    before do
      @user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
      @wiki_page = WikiPage.create(locked: false)
      @wiki_page.revisions.new(title: "Hello1", content: "world1", user: @user).save!
      @wiki_page.revisions.new(title: "Hello2", content: "world2", user: @user).save!
      @wiki_page.revisions.new(title: "Hello3", content: "world3", user: @user).save!
      @wiki_page.save
      @ids = []
      @wiki_page.revisions.each do |r|
        @ids.push(r.id)
      end
    end
    it "are deleted when their parent wiki page is" do
      @wiki_page.destroy
      @ids.each do |id|
        expect(Revision.where(id: id).first).to be_nil
      end
    end
    after do
      @wiki_page.destroy
      @user.destroy
    end
  end
end
