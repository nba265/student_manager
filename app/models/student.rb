# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  age        :integer
#  deleted_at :datetime
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_students_on_deleted_at  (deleted_at)
#
class Student < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { greater_than: 7 }
  validate :uniq_grade

  has_many :grades, -> { with_deleted }, dependent: :destroy
  has_one :media, -> { with_deleted }, dependent: :destroy
  accepts_nested_attributes_for :grades, :media, allow_destroy: true

  paginates_per 10

  acts_as_paranoid

  private

  def uniq_grade
    temp = grades.map { |grade| [grade.subject, grade.semester] }
    return unless temp.uniq.size != temp.size

    errors.add(:uniq_grade, 'Duplicate Grade')
  end
end
