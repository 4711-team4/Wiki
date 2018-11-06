require 'rails_helper'

RSpec.describe "wiki_page/show.html.erb", type: :view do
  fake_page = nil
  before do
    user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
    fake_page = WikiPage.create(locked: false)
    fake_page.revisions.new(title: "Title", content: "This is the content", user: user).save
    revisions = fake_page.revisions.all.sort_by{|revision| revision.created_at}
    current_revision = revisions.last
    assign(:page, fake_page)
    assign(:revisions, revisions)
    assign(:current_revision, current_revision)
    render
  end

  it 'should show the title and content' do
    expect(rendered).to include('Title')
    expect(rendered).to include('This is the content')
  end

  after do
    fake_page.destroy # get it out the database
    User.where(username: 'rspec').first.destroy
  end
end
