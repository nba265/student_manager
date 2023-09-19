# frozen_string_literal: true

class AddBirthdayToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :birthday, :date
  end
end
