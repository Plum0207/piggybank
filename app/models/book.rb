class Book < ApplicationRecord
  has_many :book_users
  has_many :users, through: :book_users

  validates :title, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :users, presence: true
end