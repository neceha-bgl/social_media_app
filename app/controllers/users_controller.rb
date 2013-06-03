class UsersController < ApplicationController
  before_filter :authenticate_user!

  add_breadcrumb "Users", :users_path, :except => :view
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def view
    @user = current_user
    add_breadcrumb @user.name, user_account_path
    render 'show'
  end

  def show
    authorize! :edit, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    add_breadcrumb @user.user_name, @user
  end
 
end
