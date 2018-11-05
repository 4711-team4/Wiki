# Active record model for WikiPages
# Contains html content for the wiki page

class WikiPage < ApplicationRecord
    has_many :revisions
    accepts_nested_attributes_for :revisions

    def current_revision
        r = revisions.all.sort_by{|revision| revision.created_at}
        r.last
    end
end
