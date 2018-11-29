class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.datetime :upload_date
      t.integer :width
      t.integer :height
      t.references :wiki_page
      t.integer :size

      t.timestamps
    end
  end
end
