class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order("created_at DESC")
  end

  def favorites
    @user = User.find(params[:id])
    @tweets = @user.favorites.map{ |f| f.tweet }.reverse
  end

  def follows
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end
end
