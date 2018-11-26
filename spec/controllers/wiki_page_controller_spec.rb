require 'rails_helper'

def create_temp_page
  user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
  wiki_page = WikiPage.create(locked: false)
  wiki_page.revisions.new(title: "Hello", content: "world", user: user).save!
  wiki_page.save
end

def delete_temp_page
  wiki_page = WikiPage.all.first
  wiki_page.destroy
  user = User.where(username: "rspec").first
  unless user.nil?
    user.destroy
  end
end

RSpec.describe WikiPageController, type: :controller do

  describe "GET #random" do
    context "Database is empty" do
      it "redirect to list" do
        get :random
        if WikiPage.all.blank?
          expect(response).to redirect_to(:wiki_page_index).or redirect_to(:root)
        else
          fail 'There are wiki pages in the database'
        end
      end
    end
    context 'Database has pages' do
      before do
        create_temp_page()
      end
      it 'should redirect to a random page' do
        get :random
        page = WikiPage.all.first
        expect(response).to redirect_to(page)
      end
      after do
        delete_temp_page()
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
    context "when no user is signed in" do
      before do
        create_temp_page
      end
      it "returns 302 found" do
        page = WikiPage.all.first
        get :edit, :params => {id: page.id}
        expect(response).to have_http_status(:found)
      end
      after do
        delete_temp_page
      end
    end
    context "when a user is signed in" do
      before do
        create_temp_page
        user = User.where(username: "rspec").first
        sign_in user
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
    context "when no user is signed in" do
      it "returns http found" do
        get :new
        expect(response).to have_http_status(:found)
      end
    end
    context "when a user is signed in" do
      before do
        user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
        sign_in user
      end
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      after do
        User.where(username: "rspec").first.destroy
      end
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
