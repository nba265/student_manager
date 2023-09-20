# frozen_string_literal: true

class AddColumnToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :birthday, :date
    add_column :students, :email, :string
  end
end
