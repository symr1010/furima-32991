require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品出品ができる時' do
      it '全ての値が問題なければ登録できること' do
        expect(@item).to be_valid
      end

      it '価格の範囲が、¥300~であれば登録できること' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '価格の範囲が、~¥9,999,999であれば登録できること' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    
    context '商品出品ができない時' do
      it '商品画像を1枚つけていなければ登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がなければ登録できないこと' do
        @item.product_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it '商品の説明がなければ登録できないこと' do
        @item.description_of_item = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description of item can't be blank")
      end

      it 'カテゴリーの情報がなければ登録できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end

      it '商品の状態についての情報がなければ登録できないこと' do
        @item.product_condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition Select")
      end

      it '配送料の負担についての情報がなければ登録できないこと' do
        @item.shipping_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge Select")
      end

      it '発送元の地域についての情報がなければ登録できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end

      it '発送までの日数についての情報がなければ登録できないこと' do
        @item.days_to_ship_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship Select")
      end

      it '価格についての情報がなければ登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格の範囲が、~¥300であれば登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it '価格の範囲が、~¥300であれば登録できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it '販売価格は半角数字でなければ登録できないこと' do
        @item.price = '２９９'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end  
    end
  end  
end
