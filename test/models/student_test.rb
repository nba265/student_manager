# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  age        :integer
#  birthday   :date
#  deleted_at :datetime
#  email      :string(255)
#  name       :string(255)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_students_on_deleted_at  (deleted_at)
#
require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
