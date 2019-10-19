class ChangeDefaultOfCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :name, :string, null: false, default: nil
    change_column :categories, :budget, :integer, null: false, default: 0
  end
end
