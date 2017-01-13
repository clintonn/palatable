class UsersController < ApplicationController

  # def index
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # additional logic here for validations
    @user.save
    session[:user_id] = @user.id
    redirect_to @user
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(user_params)
    redirect_to @user
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.reviews.destroy_all
    @user.destroy
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
