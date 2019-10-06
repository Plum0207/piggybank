class Record < ApplicationRecord
  belongs_to :book
  belongs_to :user

  with_options presence: true do
    validates :date
    validates :content
    validates :amount
    validates :wallet
  end
  validates :amount, numericality: { only_integer: true }
end