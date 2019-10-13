class Book < ApplicationRecord
  has_many :book_users, dependent: :destroy
  has_many :users, through: :book_users, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :users, presence: true
end