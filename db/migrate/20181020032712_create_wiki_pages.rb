class CreateWikiPages < ActiveRecord::Migration[5.2]
  def change
    create_table :wiki_pages do |t|
      t.text :html

      t.timestamps
    end
  end
end
