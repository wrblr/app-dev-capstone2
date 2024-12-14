class AddImageToResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :responses, :image, :string
  end
end
