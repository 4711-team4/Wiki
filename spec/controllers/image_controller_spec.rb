require 'rails_helper'

RSpec.describe ImageController, type: :controller do

  before do
    @user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
    @wiki_page = WikiPage.create(locked: false)
    @revision = @wiki_page.revisions.new(title: "Hello", content: "world", user: @user)
    @image = Image.new(location: "https://1.bp.blogspot.com/-8LKoU28XlQM/UqpDSu-r2DI/AAAAAAAABzQ/pbhGxkgTZNE/s1600/Great+Job+gold+star.png", width: 100, height: 100)
    @image.user = @user
    @image.wiki_page = @wiki_page
    @image.save
  end

  describe "GET #show" do
    it "returns http success" do
      id = @image.id
      get :show, params: {:id=> id}
      expect(response).to have_http_status(:success)
    end
  end

  after do
    @user.destroy
    @wiki_page.destroy
  end



end
