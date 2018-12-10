class Image < ApplicationRecord
  belongs_to :wiki_page
  belongs_to :user
  has_many :comments
end
