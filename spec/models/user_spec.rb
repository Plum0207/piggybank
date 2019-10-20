require 'rails_helper'

describe User do
  describe '#create' do
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user= build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "is invalid without an email" do
      user= build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without a password" do
      user= build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid without password_confirmation although with a password" do
      user= build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "is invalid with a nickname that has more than 12 characters" do
      user = build(:user, nickname:"あいうえおかきくけこさしす")
      user.valid?
      expect(user.errors[:nickname][0]).to include("は12文字以内で入力してください")
    end

    it "is valid with a nickname that has less than 12 characters" do
      user = build(:user, nickname:"あいうえおかきくけこさし")
      expect(user).to be_valid
    end

    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname][0]).to include("はすでに存在します")
    end

    it "is invalid with a duplicate email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email][0]).to include("はすでに存在します")
    end

    it "is valid password has more than 6 characters" do
      user = build(:user, password:"123456", password_confirmation:"123456")
      expect(user).to be_valid
    end

    it "is invalid password has less than 6 characters" do
      user = build(:user, password:"12345", password_confirmation:"12345")
      user.valid?
      expect(user.errors[:password][0]).to include("は6文字以上で入力してください")
    end
  end
end