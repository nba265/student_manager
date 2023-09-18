# frozen_string_literal: true

class AddDeletedAtToGrades < ActiveRecord::Migration[7.0]
  def change
    add_column :grades, :deleted_at, :datetime
    add_index :grades, :deleted_at
  end
end
