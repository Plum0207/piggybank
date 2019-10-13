class AddCategoryToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :category, :string, null: false
  end
end