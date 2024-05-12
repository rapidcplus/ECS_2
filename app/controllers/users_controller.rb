class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # @user は before_action で設定されているので特に処理不要
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      # ↓あえてroot_pathにリダイレクトさせる
      redirect_to root_path, success: t('users.create.success')
    else
      flash.now[:danger] = t('users.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @user は before_action で設定されているので特に処理不要
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: t('users.update.success')
    else
      flash.now[:danger] = t('users.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :message_template)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
