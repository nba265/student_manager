# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  age        :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < ApplicationRecord

  has_many :grades, dependent: :destroy
  has_one :media, dependent: :destroy
  accepts_nested_attributes_for :grades, :media, allow_destroy: true

  validates :name, presence: true
  validates :age, numericality: { greater_than: 7 }
  validate :uniq_grade

  paginates_per 10

  private

  def uniq_grade
    temp = grades.map { |grade| [grade.subject, grade.semester] }
    return unless temp.uniq.size != temp.size

    errors.add(:uniq_grade, 'Duplicate Grade')
  end
end
