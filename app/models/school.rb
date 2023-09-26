# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_schools_on_deleted_at  (deleted_at)
#
class School < ApplicationRecord
  has_many :teachers
  has_many :students

  acts_as_paranoid

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at deleted_at id name updated_at]
  end
end
