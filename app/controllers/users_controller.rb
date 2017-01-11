class UsersController < ApplicationController

  def new
    #code
  end

  def create
    @user = User.new(user_params)
    # additional logic here for validations
    @user.save
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
    binding.pry
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
