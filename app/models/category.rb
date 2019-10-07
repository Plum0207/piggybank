class Category < ApplicationRecord
  belongs_to :book

  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :budget, presence: true
end