# frozen_string_literal: true

class AddDeletedAtToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :deleted_at, :datetime
    add_index :teachers, :deleted_at
  end
end
