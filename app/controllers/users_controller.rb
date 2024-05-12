class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :update_password]

  def show; end

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

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: t('users.update.success')
    else
      flash.now[:danger] = t('users.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password
    @user = current_user # ここで適切に@userをセットする
    @user_password = UserPassword.new
  end

  def update_password
    @user_password = UserPassword.new(password_params)
    if @user_password.valid?
      # passwordとpassword_confirmationの両方をupdateメソッドに渡す
      if @user.update(password: @user_password.password, password_confirmation: @user_password.password_confirmation)
        redirect_to user_path(@user), success: t('users.update_password.success')
      else
        # ユーザーの更新がうまくいかない場合（例えば、password_confirmationが一致しない場合）
        flash.now[:danger] = t('users.update_password.failure')
        render :edit_password, status: :unprocessable_entity
      end
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :message_template)
  end

  def password_params
    params.require(:user_password).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
