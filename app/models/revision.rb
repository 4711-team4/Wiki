class Revision < ApplicationRecord
  belongs_to :user
  belongs_to :wiki_page
  validates :title, presence: true
end
