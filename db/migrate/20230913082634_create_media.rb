# frozen_string_literal: true

class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :title
      t.string :source

      t.timestamps
    end
  end
end
