require 'rails_helper'

def create_temp_page
  user = User.create(email: "rspec@example.com", username: "rspec", password: "password")
  wiki_page = WikiPage.create(locked: false)
  image = Image.new(user: user, wiki_page: wiki_page, location: 'https://1.bp.blogspot.com/-8LKoU28XlQM/UqpDSu-r2DI/AAAAAAAABzQ/pbhGxkgTZNE/s1600/Great+Job+gold+star.png')
  image.save
  wiki_page.revisions.new(title: "Hello", content: "world<img src='#{image.location}'/>", user: user).save!
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

RSpec.describe WikiPageHelper, type: :helper do
  before do
    @page = create_temp_page
    p @page
  end

  describe 'Adding image links' do
    it 'should add a link to an image' do
      output =  helper.add_image_links_to_content @page.revisions.last
      images = output.css 'img'
      links = output.css 'a'
      expect(images.size).to eq links.size
    end
  end

  after do
    delete_temp_page
  end
end