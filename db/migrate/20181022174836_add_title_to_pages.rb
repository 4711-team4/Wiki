class AddTitleToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :wiki_pages, :title, :string
  end
end
