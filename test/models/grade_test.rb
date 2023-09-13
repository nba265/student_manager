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
require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
