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

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    unless @user == current_user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_path, :notice => "User deleted."  }
        format.js 
      end
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

end
