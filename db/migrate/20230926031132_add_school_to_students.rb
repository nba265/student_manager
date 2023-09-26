# frozen_string_literal: true

class AddSchoolToStudents < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :school, null: true, foreign_key: true
  end
end
