class WikiPage < ActiveRecord::Migration[5.2]
  def change
    rename_column :wiki_pages, :html, :content
  end
end
