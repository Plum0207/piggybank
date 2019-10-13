class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :budget, null: false
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
