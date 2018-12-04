require 'rails_helper'

def create_temp_page
  user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
  wiki_page = WikiPage.create(locked: false)
  wiki_page.revisions.new(title: "Hello", content: "world", user: user).save!
  wiki_page.save
  return wiki_page
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
    before do
    end
    it 'should redirect to a random page' do
      WikiPage.destroy_all
      get :random
      expect(response).to redirect_to(:wiki_page_index).or redirect_to(:root)
      @page = create_temp_page
      get :random
      expect(response).to redirect_to(@page)
    end
    after do
      @page.destroy
      User.where(username: "rspec").first.destroy
    end
  end

  describe "GET #show" do
    before do
      @page = create_temp_page
    end
    it "returns http success" do
      get :show, :params => {id: @page.id}
      expect(response).to have_http_status(:success)
    end
    after do
      @page.destroy
      User.where(username: "rspec").first.destroy
    end
  end

  describe "GET #edit" do
    context "when no user is signed in" do
      before do
        @page = create_temp_page
      end
      it "returns 302 found" do
        get :edit, :params => {id: @page.id}
        expect(response).to have_http_status(:found)
      end
      after do
        @page.destroy
        User.where(username: "rspec").first.destroy
      end
    end
    context "when a user is signed in" do
      before do
        @page = create_temp_page
        user = User.where(username: "rspec").first
        controller.sign_in user
      end
      it "returns http success" do
        get :edit, :params => {id: @page.id}
        expect(response).to have_http_status(:success)
      end
      after do
        @page.destroy
        User.where(username: "rspec").first.destroy
      end
    end
  end

  describe "PUT #update/:id" do
    let(:attr) do 
      { :revisions_attributes => {"0" => {:title => 'New title', :content => 'New Content' } } }
    end
  
    before do
      user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
      controller.sign_in user
      @page = create_temp_page
      put :update, params: {:id => @page.id, :wiki_page => attr}
      @page.reload
    end
  
    it { expect(response).to redirect_to(@page) }
    it { expect(@page.current_revision.title).to eq 'New title' }
    it { expect(@page.current_revision.content).to eq 'New Content' }
  end

  describe "POST #create" do
    let(:attr) do 
      { :revisions_attributes => {"0" => {:title => 'New title', :content => 'New Content' } } }
    end

    it "creates a new page" do
      user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
      controller.sign_in user
      expect { post :create, params: {:wiki_page => attr} }.to change(WikiPage, :count).by(1) 
    end
  end

  describe "GET #new" do
    context "when a user is signed in" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:found)
        user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
        controller.sign_in user
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
      WikiPage.destroy_all
      render_views
      it "Shows a no article message" do
        get :index
        expect(response.body).to include('No Wiki pages on the site :(')
      end
    end
  end
end
