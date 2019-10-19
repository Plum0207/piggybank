class ChangeDatatypebudgetOfCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :budget, 'integer USING CAST(budget AS integer)', default: nil
  end
end
