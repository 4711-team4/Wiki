class Image < ApplicationRecord
  belongs_to :wiki_page
  belongs_to :user
end
