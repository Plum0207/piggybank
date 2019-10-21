# Features
- can make as many books as you want
- can set categories for each book
- can check expenditure by category
- books can be shared more than two people
  - shared book is suitable for household account book for DINKS
  - book used by one is suitable for pocketbook

# DB
## users
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false|
|password|string|null: false|

### Association
- has_many :book_users
- has_many :books, through: :book_users
- has_many :records

## books
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|

### Association
- has_many :book_users
- has_many :users through: :book_users
- has_many :records

## book-users
|column|type|Options|
|------|----|-------|
|book|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :book
- belongs_to :user

## records
|column|type|Options|
|------|----|-------|
|date|datetime|null: false|
|content|string|null: false|
|amount|integer|null: false|
|category|string|null:false|
|wallet|string|null: false|
|book|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :book
- belongs_to :user

### categories
|column|type|Options|
|------|----|-------|
|name|string|null: false|
|budget|integer|null: fals|
|book|references|null: false, foreign_key: true|

### Association
- belongs_to :book