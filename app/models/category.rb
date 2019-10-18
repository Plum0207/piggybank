class Category < ApplicationRecord
  belongs_to :book

  validates :name, presence: true, length: { maximum: 10 }
  validates :budget, presence: true, numericality: { only_integer: true }

  def records(book)
    @category_records = book.records.where(category: "#{self.name}")
  end

  def records_amount(book)
    records(book)
    total_amount = 0
    @category_records.each do |record|
      total_amount += record.amount
    end
    return total_amount
  end

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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      category = new
      category.attributes = row.to_hash.slice(*csv_attributes)
      category.save!
    end
  end
end