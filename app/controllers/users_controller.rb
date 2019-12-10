class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "#{@user.username} 您好！"
    else
      @error_message = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
