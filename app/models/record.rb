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
  validates :content, length: { maximum: 20 }
  validates :amount, numericality: { only_integer: true }

  scope :recent, -> { order(date: :desc) }
  scope :old, -> {order(date: :asc)}

  def self.ransackable_attributes(auth_object = nil)
    %w[date content category wallet]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.csv_attributes
    ["date", "content", "amount", "category", "wallet"]
  end

  def self.csv_attributes_ja
    ["日付", "内容", "金額", "費目", "支払者"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes_ja
      all.old.each do |record|
        csv << csv_attributes.map{ |attr| record.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row = row.to_hash.slice(*csv_attributes_ja)
      self.create(
        date: row["日付"],
        content: row["内容"],
        amount: row["金額"],
        category: row["費目"],
        wallet: row["支払者"]
      )
    end
  end
end