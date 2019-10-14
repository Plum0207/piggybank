class Category < ApplicationRecord
  belongs_to :book

  validates :name, presence: true, length: { maximum: 10 }
  validates :budget, presence: true

  def self.csv_attributes
    ["name", "budget"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |category|
        csv << csv_attributes.map { |attr| category.send(attr) }
      end
    end
  end
end