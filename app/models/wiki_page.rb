# Active record model for WikiPages
# Contains html content for the wiki page

class WikiPage < ApplicationRecord
  attr_accessor :html, :title
end
