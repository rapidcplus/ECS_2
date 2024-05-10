class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to items_url, success: t('items.create.success')
    else
      flash.now[:danger] = t('items.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = current_user.items.find(params[:id])
    if @item.update(item_params)
      redirect_to items_url(@item), success: t('defaults.flash_message.updated', item: Item.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Item.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:title, :item_url)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
