class AddCludinaryUrlToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :cloudinary_url, :string, null: true
  end
end
