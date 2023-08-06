class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

    # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  #　フォロワー一覧
  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
     redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end