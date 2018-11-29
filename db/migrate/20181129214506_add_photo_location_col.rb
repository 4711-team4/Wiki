class AddPhotoLocationCol < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :location, :string
  end
end
