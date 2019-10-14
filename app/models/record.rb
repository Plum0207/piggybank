class Record < ApplicationRecord
  belongs_to :book
  belongs_to :user

  with_options presence: true do
    validates :date
    validates :content
    validates :amount
    validates :category
    validates :wallet
  end
  validates :amount, numericality: { only_integer: true }

  def self.csv_attributes
    ["date", "content", "amount", "category", "wallet"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |record|
        csv << csv_attributes.map{ |attr| record.send(attr) }
      end
    end
  end
end