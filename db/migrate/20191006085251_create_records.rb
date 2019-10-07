class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.datetime :date, null: false
      t.string :content, null: false
      t.integer :amount, null: false
      t.string :wallet, null: false
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
