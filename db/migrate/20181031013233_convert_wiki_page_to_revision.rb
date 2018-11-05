class ConvertWikiPageToRevision < ActiveRecord::Migration[5.2]
  def change
    remove_column :wiki_pages, :title
    remove_column :wiki_pages, :content
    add_column :wiki_pages, :locked, :boolean, default: false
  end
end
