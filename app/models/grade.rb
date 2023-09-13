# frozen_string_literal: true

# == Schema Information
#
# Table name: grades
#
#  id         :bigint           not null, primary key
#  commest    :text(65535)
#  score      :integer
#  semester   :integer
#  subject    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_grades_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class Grade < ApplicationRecord
  validates :subject, presence: true # , uniqueness: {scope: [:semester,:student_id], message: "Duplicate subject"}
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :semester, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  enum subject: { math: 0, science: 1, history: 2, literature: 3 }

  belongs_to :student
end
