class UsersController < ApplicationController

  # def index
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      errors = @user.errors.full_messages.to_sentence
      flash[:notice] = errors
      redirect_to login_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(user_params)
    if @user.valid?
      redirect_to @user
    else
      flash[:notice] = "Invalid email or password."
      redirect_to edit_user_path
    end
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
