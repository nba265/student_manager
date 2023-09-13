# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  age        :integer
#  avatar     :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
