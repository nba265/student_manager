# frozen_string_literal: true

class AddDeletedAtToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :deleted_at, :datetime
    add_index :schools, :deleted_at
  end
end
