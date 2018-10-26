require 'rails_helper'

RSpec.describe "wiki_page/show.html.erb", type: :view do
  fake_page = nil
  before do
    fake_page = WikiPage.new(title: 'Title', content: 'This is the content')
    fake_page.save # need to store it the db so it has some methods defined
    assign(:page, fake_page)
    render
  end
  it 'should show the title and content' do
    expect(rendered).to include('Title')
    expect(rendered).to include('This is the content')
  end

  after do
    fake_page.destroy # get it out the database
  end
end
