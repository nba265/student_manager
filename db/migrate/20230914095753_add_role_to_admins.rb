# frozen_string_literal: true

class AddRoleToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :role, :integer
  end
end
