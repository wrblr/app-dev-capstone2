class AddImageToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :image, :string
  end
end
