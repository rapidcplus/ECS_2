class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]

  def index
    @items = current_user.items.order(created_at: :desc)
    # @items = Item.includes(:user).order(created_at: :desc)
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

  # def create
  #   @item = Item.new(item_params)
  #   @item.user_id = current_user.id
  #   if @item.save
  #     redirect_to items_url, flash: { success: t('defaults.flash_message.created', item: Item.model_name.human) }
  #   else
  #     flash.now[:danger] = t('defaults.flash_message.not_created', item: Item.model_name.human)
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:success] = "アイテムを作成しました"
      redirect_to items_url
    else
      flash.now[:danger] = "アイテムの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_url(@item), flash: { success: t('defaults.flash_message.updated', item: Item.model_name.human) }
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Item.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, flash: { success: t('defaults.flash_message.deleted', item: Item.model_name.human) }
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :item_url)
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end

  def set_item
    @item = current_user.items.find(params[:id])
  end
end
