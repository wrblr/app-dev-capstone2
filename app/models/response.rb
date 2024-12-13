# == Schema Information
#
# Table name: responses
#
#  id           :bigint           not null, primary key
#  body_text    :string
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  questions_id :integer
#
class Response < ApplicationRecord
end
