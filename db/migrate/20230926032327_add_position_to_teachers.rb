# frozen_string_literal: true

class AddPositionToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :position, :integer
  end
end
