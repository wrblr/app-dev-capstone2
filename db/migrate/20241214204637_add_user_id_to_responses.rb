class AddUserIdToResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :responses, :user_id, :integer
  end
end
