class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new] # :edit, :destroy
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end  
  
  def update
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description_of_item, :category_id, :product_condition_id, :shipping_charge_id,
                                 :prefecture_id, :days_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end
