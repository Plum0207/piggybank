class Category < ApplicationRecord
  belongs_to :book

  validates :name, presence: true, length: { maximum: 10 }
  validates :budget, presence: true, numericality: { only_integer: true }

  scope :chronological, -> { order(created_at: :asc)}

  def records(book)
    @category_records = book.records.where(category: "#{self.name}")
  end

  def records_amount(book)
    records(book)
    @category_records.sum(:amount)
  end

  def self.csv_attributes
    ["name", "budget"]
  end

  def self.csv_attributes_ja
    ["費目", "予算"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes_ja
      all.each do |category|
        csv << csv_attributes.map { |attr| category.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row = row.to_hash.slice(*csv_attributes_ja)
      self.create(
        name: row["費目"],
        budget: row["予算"]
      )
    end
  end
end