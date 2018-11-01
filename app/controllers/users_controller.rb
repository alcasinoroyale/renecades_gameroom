class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "User created successfully!"
      redirect_to user_path(@user)
    else
      @user.errors.full_messages
      flash[:message] = "This user info already exists."
      render :new
    end
  end

  def show
    @users = User.all
    if logged_in?
      @user = User.find_by(id: params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    #want to automatically update reward points each type a user plays a game
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :favorite_game, :bio, :reward_points)
  end
end
