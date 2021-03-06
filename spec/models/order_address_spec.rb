require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入の情報' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    context '保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'tokenが空では保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空だと保存できないこと' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にはハイフンがないと保存できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が1だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture Select')
      end

      it '市区町村が空だと保存できないこと' do
        @order_address.municipality = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にハイフンが含まれていると保存できないこと' do
        @order_address.phone_number = '000-1111-2222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end

      it '電話番号には11桁以内でないと保存できないこと' do
        @order_address.phone_number = '0001111222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end

      it '電話番号が英数混合の場合保存できないこと' do
        @order_address.phone_number = '0a0a0a0a0a0'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end

      it 'user_idが空の場合保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空の場合保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
