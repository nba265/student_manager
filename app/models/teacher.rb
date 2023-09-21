# frozen_string_literal: true

# == Schema Information
#
# Table name: teachers
#
#  id         :bigint           not null, primary key
#  age        :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Teacher < ApplicationRecord
  has_many :courses, class_name: 'course', foreign_key: 'reference_id'
end
