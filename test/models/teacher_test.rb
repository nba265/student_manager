# frozen_string_literal: true

# == Schema Information
#
# Table name: teachers
#
#  id         :bigint           not null, primary key
#  age        :integer
#  deleted_at :datetime
#  name       :string(255)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_teachers_on_deleted_at  (deleted_at)
#  index_teachers_on_school_id   (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
