class UsersController < ApplicationController

  def new
    #code
  end

  def create
    #code
  end

  def show
    @user = User.find(params[:id])
  end

end
