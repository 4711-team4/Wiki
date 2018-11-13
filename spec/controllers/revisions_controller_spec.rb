require 'rails_helper'

RSpec.describe RevisionsController, type: :controller do

  describe "GET #show" do
    before do
      @user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
      @wiki_page = WikiPage.create(locked: false)
      @revision = @wiki_page.revisions.new(title: "Hello", content: "world", user: @user)
      @revision.save
      @wiki_page.save
    end
    it "returns http success" do
      get :show, params: {wiki_page_id: @wiki_page.id, id: @revision.id}
      expect(response).to have_http_status(:success)
    end
    after do
      @wiki_page.destroy
      @user.destroy
    end
  end
end
