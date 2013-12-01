class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def update_email
    @user = current_user
    if @user.update(user_params)
      sign_in @user, bypass: true
      flash[:notice] = "Your email was changed."
      redirect_to root_path
    else
      flash[:alert] = "Make sure to enter a valid email address."
      render 'index'
    end
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      sign_in @user, bypass: true
      flash[:notice] = "Your password was changed."
      redirect_to root_path
    else
      flash[:alert] = "Your password was not changed, we did a whoopsie."
      render "index"
    end
  end

  private

  def user_params
    params.required(:user).permit(:email, :password, :password_confirmation)
  end
end
