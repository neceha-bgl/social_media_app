class UsersController < ApplicationController
  before_filter :authenticate_user!

  add_breadcrumb "Users", :users_path, :except => :view
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    term  = params[:search]
    @users = User.joins(:roles).select("users.*, roles.id as role_id, roles.name as role_name").where("users.user_name like :term or users.first_name like :term or users.last_name like :term", term: "%#{term}%").paginate(:page => params[:page], :per_page => 25)
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

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user], :as => :admin)
        format.html {redirect_to :back , :notice => "User updated."}
        format.json {head :no_content}
        format.js
      else
        format.html {redirect_to :back, :alert => "Unable to update user." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
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
