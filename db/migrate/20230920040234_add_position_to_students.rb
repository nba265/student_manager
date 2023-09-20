# frozen_string_literal: true

class AddPositionToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :position, :integer
  end
end
