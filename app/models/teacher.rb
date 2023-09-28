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
class Teacher < ApplicationRecord
  before_create :set_default_position
  has_many :courses, class_name: 'course', foreign_key: 'reference_id'
  belongs_to :school

  validates :school_id, :name, :age, presence: true

  paginates_per 10

  acts_as_paranoid

  def self.ransackable_attributes(_auth_object = nil)
    %w[age created_at deleted_at id name position school_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[courses school]
  end

  def set_default_position
    highest_position = Teacher.maximum(:position)
    self.position = highest_position ? highest_position + 1 : 1
  end
end
