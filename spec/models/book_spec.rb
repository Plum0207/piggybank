require 'rails_helper'

describe Book do
  describe '#create' do
    it "is valid with a title, users" do
      book = build(:book)
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = build(:book, title: "")
      book.valid?
      expect(book.errors[:title]).to include("を入力してください")
    end

    it "is invalid without a user" do
      book = build(:book, users: [])
      book.valid?
      expect(book.errors[:users]).to include("を入力してください")
    end

    it "is invalid with a title that has more than 20 characters" do
      book = build(:book, title:"あいうえおかきくけこさしすせそたちつてとな")
      book.valid?
      expect(book.errors[:title][0]).to include("は20文字以内で入力してください")
    end

    it "is valid with a title that has less than 20 characters" do
      book = build(:book, title:"あいうえおかきくけこさしすせそたちつてと")
      expect(book).to be_valid
    end
  end
end