require 'rails_helper'

describe Record do
  describe '#create' do
    it "is valid with a date, content, amount, category, wallet" do
      record = build(:record)
      expect(record).to be_valid
    end

    it "is invalid without date" do
      record = build(:record, date: "")
      record.valid?
      expect(record.errors[:date]).to include("を入力してください")
    end

    it "is invalid without content" do
      record = build(:record, content: "")
      record.valid?
      expect(record.errors[:content]).to include("を入力してください")
    end

    it "is invalid without amount" do
      record = build(:record, amount: "")
      record.valid?
      expect(record.errors[:amount]).to include("を入力してください")
    end

    it "is invalid without category" do
      record = build(:record, category: "")
      record.valid?
      expect(record.errors[:category]).to include("を入力してください")
    end

    it "is invalid without wallet" do
      record = build(:record, wallet: "")
      record.valid?
      expect(record.errors[:wallet]).to include("を入力してください")
    end

    it "is invalid with a content that has more than 20 characters" do
      record = build(:record, content:"あいうえおかきくけこさしすせそたちつてとな")
      record.valid?
      expect(record.errors[:content][0]).to include("は20文字以内で入力してください")
    end

    it "is valid with a title that has less than 20 characters" do
      record = build(:record, content:"あいうえおかきくけこさしすせそたちつてと")
      expect(record).to be_valid
    end

    it "is invalid with a amount other than numbers" do
      record = build(:record, amount:"文字列")
      record.valid?
      expect(record.errors[:amount][0]).to include("は数値で入力してください")
    end
  end
end