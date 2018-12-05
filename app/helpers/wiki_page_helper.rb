module WikiPageHelper
  def add_image_links_to_content(page)
    content = Nokogiri::HTML.fragment(page.content)
    images = content.css('img')

    images.each do |img|
      # get the image model
      model = page.wiki_page.images.where("location = '#{img['src']}'")
      # create the link
      link = Nokogiri::XML::Node.new 'a', content
      link['href'] = "/image/#{model.ids[0]}" # find a way to include rails route functions
      img.add_next_sibling link
      img.parent = link
    end
    content# send the modified content back
  end
end