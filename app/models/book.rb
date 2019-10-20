class Book < ApplicationRecord
  has_many :book_users, dependent: :destroy
  has_many :users, through: :book_users, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :users, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def users_order
    self.users.order("nickname ASC")
  end

  def users_list
    users_list = ""
    self.users_order.each do |user|
      users_list += "#{user.nickname}　"
    end
    return users_list
  end

end