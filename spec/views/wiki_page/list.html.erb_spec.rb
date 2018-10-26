require 'rails_helper'

RSpec.describe "wiki_page/index.html.erb", type: :view do
  context 'No wikis in the database' do
    before do
      assign(:pages, []) # empty wiki
      render
    end
    it 'should show a no wiki page message' do
      expect(rendered).to include 'No Wiki pages on the site :('
    end
  end
end
