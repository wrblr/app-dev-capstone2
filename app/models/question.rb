# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  has_many  :messages, class_name: "Response", foreign_key: "questions_id", dependent: :destroy
  validates :topic, presence: true
  validates :topic, uniqueness: true
end
