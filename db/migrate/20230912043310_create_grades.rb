# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.integer :subject
      t.integer :score
      t.integer :semester
      t.text :commest
      t.belongs_to :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
