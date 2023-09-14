class RemoveAvatarFromStudent < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :avatar, :string
  end
end
