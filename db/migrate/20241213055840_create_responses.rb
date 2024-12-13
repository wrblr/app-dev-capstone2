class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.integer :questions_id
      t.string :body_text
      t.string :role

      t.timestamps
    end
  end
end
