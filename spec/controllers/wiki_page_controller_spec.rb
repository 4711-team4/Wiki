require 'rails_helper'

def create_temp_page
  wiki_page = WikiPage.new(title: 'Hello', content: 'world')
  wiki_page.save
end

def delete_temp_page
  wiki_page = WikiPage.all.first
  wiki_page.destroy
end

RSpec.describe WikiPageController, type: :controller do

  describe "GET #random" do
    context "Database is empty" do
      it "redirect to list" do
        get :random
        if WikiPage.all.blank?
          expect(response).to redirect_to(:wiki_page_index)
        else
          fail 'There are wiki pages in the database'
        end
      end
    end
    context 'Database has pages' do
      before do
        page = WikiPage.new(title: "Test Page", content: "test")
        page.save
      end
      it 'should redirect to a random page' do
        get :random
        page = WikiPage.all.first
        expect(response).to redirect_to(page)
      end
      after do
        page = WikiPage.find_by(title: "Test Page")
        page.destroy
      end
    end
  end

  describe "GET #show" do
    before do
      create_temp_page
    end
    it "returns http success" do
      page = WikiPage.all.first
      get :show, :params => {id: page.id}
      expect(response).to have_http_status(:success)
    end
    after do
      delete_temp_page
    end
  end

  describe "GET #edit" do
    before do
      create_temp_page
    end
    it "returns http success" do
      page = WikiPage.all.first
      get :edit, :params => {id: page.id}
      expect(response).to have_http_status(:success)
    end
    after do
      delete_temp_page
    end
  end

  describe "GET #update" do
  end

  describe "POST #create" do
    # it 'should create a wiki page' do
    #   title = 'Hello World!'
    #   content = '<h2> Whats going on? </h2>'
    #   post :update, params: {:wiki_page => {title: title, content: content}}
    #
    #   page = WikiPage.all.first
    #   expect(page.title).to eq(title)
    #   expect(page.content).to eq(content)
    #   expect(response).to redirect_to(page)
    # end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    context "No Pages in the list" do
      render_views
      it "Shows a no article message" do
        get :index
        expect(response.body).to include('No Wiki pages on the site :(')
      end
    end
  end

end
