# frozen_string_literal: true

class AddSchoolToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_reference :teachers, :school, null: true, foreign_key: true
  end
end
