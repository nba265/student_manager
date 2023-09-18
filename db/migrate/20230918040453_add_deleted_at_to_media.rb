# frozen_string_literal: true

class AddDeletedAtToMedia < ActiveRecord::Migration[7.0]
  def change
    add_column :media, :deleted_at, :datetime
    add_index :media, :deleted_at
  end
end
