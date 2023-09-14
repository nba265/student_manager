# frozen_string_literal: true

class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.string :video
      t.string :audio
      t.string :avatar

      t.timestamps
    end
  end
end
