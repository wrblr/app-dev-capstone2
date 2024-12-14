# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  image      :string
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  has_many  :responses, class_name: "Response", foreign_key: "questions_id", dependent: :destroy
  validates :topic, presence: true
  validates :topic, uniqueness: true
  mount_uploader :image, ImageUploader
end
