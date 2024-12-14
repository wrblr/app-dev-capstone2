# == Schema Information
#
# Table name: responses
#
#  id           :bigint           not null, primary key
#  body_text    :string
#  image        :string
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  questions_id :integer
#  user_id      :integer
#
class Response < ApplicationRecord
  belongs_to :question, required: true, class_name: "Question", foreign_key: "questions_id"
  validates :role, inclusion: { in: [ "system", "user", "helper" ] }
  validates :role, presence: true
  validates :body_text, presence: true
end
