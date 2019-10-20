require 'rails_helper'

describe Category do
  describe '#create' do
    it "is valid with a name, budget" do
      category = build(:category)
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category = build(:category, name: "")
      category.valid?
      expect(category.errors[:name]).to include("を入力してください")
    end

    it "is invalid without a budget" do
      category = build(:category, budget: "")
      category.valid?
      expect(category.errors[:budget]).to include("を入力してください")
    end

    it "is invalid with a name that has more than 10 characters" do
      category = build(:category, name: "あいうえおかきくけこさ")
      category.valid?
      expect(category.errors[:name]).to include("は10文字以内で入力してください")
    end

    it "is valid with a name that has more than 10 characters" do
      category = build(:category, name: "あいうえおかきくけこ")
      expect(category).to be_valid
    end

    it "is invalid with a budget other than numbers" do
      category = build(:category, budget: "あいうえお")
      category.valid?
      expect(category.errors[:budget]).to include("は数値で入力してください")
    end
  end
end