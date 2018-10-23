require 'rails_helper'

RSpec.describe WikiPageController, type: :controller do

  describe "GET #random" do
    it "returns http success" do
      get :random
      if WikiPage.all.blank?
        expect(response).to redirect_to(:wiki_page_list)
      else
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    # it "returns http success" do
    #   get :show
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe "GET #edit" do
    # it "returns http success" do
    #   get :edit
    #   expect(response).to have_http_status(:success)
    # end
  end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :list
      expect(response).to have_http_status(:success)
    end
    context "No Pages in the list" do
      render_views
      it "Shows a no article message" do
        get :list
        expect(response.body).to include('No Wiki pages on the site :(')
      end
    end
  end

end
