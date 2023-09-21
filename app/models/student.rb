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
#  first_name :string(255)
#  last_name  :string(255)
#  name       :string(255)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_students_on_deleted_at  (deleted_at)
#
class Student < ApplicationRecord
  before_create :set_default_position
  validates :name, :position, presence: true
  validates :age, numericality: { greater_than: 7 }
  validate :uniq_grade
  validates :email, uniqueness: true

  has_many :grades, -> { with_deleted }, dependent: :destroy
  has_one :media, -> { with_deleted }, dependent: :destroy
  accepts_nested_attributes_for :grades, :media, allow_destroy: true

  paginates_per 10

  acts_as_paranoid

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end
  # def save_with_position
  #   highest_position = Student.maximum(:position)
  #   new_position = highest_position ? highest_position + 1 : 1

  #   self.position = new_position
  #   save
  # end

  def set_default_position
    highest_position = Student.maximum(:position)
    self.position = highest_position ? highest_position + 1 : 1
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def self.ransackable_attributes(_auth_object = nil)
    %w[address age birthday created_at deleted_at email first_name id last_name name
       position updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[grades media]
  end


  def uniq_grade
    temp = grades.map { |grade| [grade.subject, grade.semester] }
    return unless temp.uniq.size != temp.size

    errors.add(:uniq_grade, 'Duplicate Grade')
  end
end
