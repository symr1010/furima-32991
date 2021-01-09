require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての値が問題なければ登録できること' do
      expect(@user).to be_valid
    end  

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは、@を含まない場合は登録できないこと' do
      @user.email = 'testtest.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = 'sample10103'
      @user.password_confirmation = 'sample10103'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'sam10'
      @user.password_confirmation = 'sam10'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordは、数字のみでは登録できないこと' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には半角英数字混合文字を使用してください")
    end

    it 'passwordは、英文字のみでは登録できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には半角英数字混合文字を使用してください")
    end  

    it 'passwordは、全角では登録できないこと' do
      @user.password = 'ABCDEF'
      @user.password_confirmation = 'ABCDEF'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には半角英数字混合文字を使用してください")
    end  

    it 'passwordは、確認用を含めて2回入力しないと登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordとpassword（確認用）、値の不一致では登録ができないこと' do
      @user.password_confirmation = 'sample10103'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名は、last_nameがないと登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー本名は、first_nameがないと登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー本名の、last_nameには全角（漢字・ひらがな・カタカナ）で入力しないと登録できないこと' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name には全角文字を使用してください')
    end

    it 'ユーザー本名の、first_nameには全角（漢字・ひらがな・カタカナ）で入力しないと登録できないこと' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name には全角文字を使用してください')
    end

    it 'ユーザー本名のフリガナは、last_name_kanaがないと登録できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、first_name_kanaがないと登録できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、last_name_kanaには全角（カタカナ）で入力しないと登録できないこと' do
      @user.last_name_kana = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana には全角(カタカナ)文字を使用してください')
    end

    it 'ユーザー本名のフリガナは、first_name_kanaには全角（カタカナ）で入力しないと登録できないこと' do
      @user.first_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana には全角(カタカナ)文字を使用してください')
    end

    it '生年月日が必須であること' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
