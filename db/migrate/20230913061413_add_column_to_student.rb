# frozen_string_literal: true

class AddColumnToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :age, :integer
    add_column :students, :address, :string
  end
end
